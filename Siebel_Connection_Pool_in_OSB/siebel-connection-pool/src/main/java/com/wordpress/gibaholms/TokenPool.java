package com.wordpress.gibaholms;


import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.Queue;

public class TokenPool {
	
	private static final int SIEBEL_TOKEN_EXPIRATION_IN_MINUTES = 15;
	
	private static final Map<SiebelCredential, Queue<SiebelToken>> tokensByCredential;
	private static long addCount;
	private static long pollCount;
	private static long hitCount;
	private static long missCount;
	
	static {
		tokensByCredential = new HashMap<SiebelCredential, Queue<SiebelToken>>();
	}
	
	public synchronized static String pollToken(String username, String password) {
		pollCount++;
		SiebelCredential credential = new SiebelCredential(username, password);
		if (tokensByCredential.containsKey(credential)) {
			Queue<SiebelToken> tokens = tokensByCredential.get(credential);
			while (tokens.size() > 0) {
				SiebelToken token = tokens.poll();
				long diffInMinutes = (System.currentTimeMillis() - token.getCreationDate().getTime()) / (60 * 1000);
				if (diffInMinutes < SIEBEL_TOKEN_EXPIRATION_IN_MINUTES) {
					hitCount++;
					return token.getToken();
				}
			}
		}
		missCount++;
		return null;
	}
	
	public synchronized static void addToken(String username, String password, String token) {
		addCount++;
		SiebelCredential credential = new SiebelCredential(username, password);
		if (!tokensByCredential.containsKey(credential)) {
			tokensByCredential.put(credential, new LinkedList<SiebelToken>());
		}
		tokensByCredential.get(credential).add(new SiebelToken(token));
	}

	public static void eraseCounters() {
		addCount = 0;
		pollCount = 0;
		hitCount = 0;
		missCount = 0;
	}
	
	public static long getAddCount() {
		return addCount;
	}

	public static long getPollCount() {
		return pollCount;
	}

	public static long getHitCount() {
		return hitCount;
	}

	public static long getMissCount() {
		return missCount;
	}
	
}
