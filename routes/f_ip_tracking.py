from globals import *
from routes.helpers import *
from flask import Blueprint, make_response

app = Blueprint('ip_tracking', __name__, template_folder='templates')


@app.route('/ip_tracking/status')
@auth_required
def get_ip_tracking(login, userid):
	db = Db("database.db")
	user = db.get_user_by_id(userid['userid'])
	if user is None:
		return '', 404
	return user["ip_tracking"]


@app.route('/ip_tracking/ping')
@auth_required
def ping(userid):
	return '', 200


@app.route('/ip_tracking/enable')
@auth_required
def enable_ip_tracking(userid):
	db = Db("database.db")
	if db.is_banned(userid['userid']):
		return 'banned', 403
	success = db.set_ip_tracking(userid['userid'], True)
	db.close()
	if not success:
		return '', 400
	return redirect('/settings/', 307)


@app.route('/ip_tracking/disable')
@auth_required
def disable_ip_tracking(userid):
	db = Db("database.db")
	if db.is_banned(userid['userid']):
		return 'banned', 403
	success = db.set_ip_tracking(userid['userid'], False)
	db.close()
	if not success:
		return '', 400
	return redirect('/settings/', 307)
