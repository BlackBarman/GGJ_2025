extends Node

signal BubbleBasePopped(bubble_base : BubbleBase)
signal BubbleBulletSent()
signal BubbleBulletPopped()
signal PlayerDied()
signal MaxBubbleBulletsSet(bubble_bullets : int)
signal PlayerHealthChanged(new_value : int, max_value : int)
signal EnemyDiedInExplosion(enemy_score : int, enemy_position : Vector3)
