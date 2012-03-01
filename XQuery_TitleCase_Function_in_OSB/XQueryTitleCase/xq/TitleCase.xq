(:: pragma type="xs:string" ::)

declare namespace xf = "http://tempuri.org/xq/TitleCase/";

declare function xf:TitleCase($str as xs:string) as xs:string {
	let $words := tokenize($str, '\s')
	return 
		let $result := 
			for $word in $words
			return concat(upper-case(substring($word, 1, 1)), substring($word, 2))
		return string-join($result, ' ')
};

declare variable $str as xs:string external;

xf:TitleCase($str)
