function renderEjs(router_name, team_token){
	$.redirect('/'+router_name, {'token': team_token});
}