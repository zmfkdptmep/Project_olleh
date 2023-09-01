
	/*
	* fetch Get 방식
	*/
	function fetchGet(url, callback){
		console.log(url);
		console.log(callback);
		
		try {
		fetch(url)
		.then (response => response.json())
		.then(map =>callback(map));
			
		} catch (e) {
			consol.log('fetchGet', e);
		}
	}
	
	
	/*
	* fetch Post 방식
	*/
	function fetchPost(url, obj, callback){
		try {
		fetch(url, {method : 'post', headers : {'Content-Type' : 'application/json'}, body : JSON.stringify(obj)})
		.then(response => response.json())
		.then(map => callback(map));
			
		} catch (e) {
			consol.log('fetchPost',e);
		}
	}