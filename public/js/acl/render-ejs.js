function renderEjs(router_name, team_token){
	$.redirect('/'+router_name, {'token': team_token});
}

function renderEjs2(router_name, team_token, firstBid){
	$.redirect('/' + router_name, {'token': team_token, 'firstBid':firstBid});
}