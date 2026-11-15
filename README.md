angular_velocity*=0.8**delta
	var brungitis = dot(Vector3(-sin(get_viewport().get_camera_3d().global_rotation.y), 0, -cos(get_viewport().get_camera_3d().global_rotation.y)),Vector3(-sin(self.global_rotation.y), 0, -cos(self.global_rotation.y)))
	var GOLDDD = 2.5
	GOLDDD*=((180/(abs(brungitis)+180)))
	if brungitis > 0:
		apply_torque(Vector3(0,GOLDDD,0))
	else:
		apply_torque(Vector3(0,-GOLDDD,0))
	print(GOLDDD)
	if abs(brungitis)-180 < 14:
		
		apply_central_force(15*Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y)))
