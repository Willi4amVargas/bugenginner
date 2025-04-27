class_name Entity
extends Resource

@export var entity_sprite:Texture2D
@export var name:String
@export var life_color:Color

@export var life:float
@export var damage:float
@export var defense:float
@export var abilities:Array[Abilitie]

@export var entity_velocity:float

func make_damage(damage_recived:int)->void:
	life -= damage_recived
