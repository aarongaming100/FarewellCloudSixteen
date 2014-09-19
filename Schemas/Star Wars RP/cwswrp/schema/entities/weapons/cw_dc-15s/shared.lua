if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.PrintName			= "DC-15s"	
	SWEP.Author				= "RJ"
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 82
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.NameOfSWEP			= "cw_dc-15s"
	SWEP.Slot				= 0
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "t"
	killicon.AddFont( SWEP.NameOfSWEP, "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end

SWEP.Category				= "Star Wars"
SWEP.Base					= "weapon_base"

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false
SWEP.HoldType				= "pistol"
SWEP.ViewModel				= "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel				= "models/weapons/w_pist_p228.mdl"

SWEP.Primary.Sound 			= Sound( "blaster_edited.wav" )
SWEP.Primary.Damage 		= 15
SWEP.Primary.TakeAmmo 		= 1
SWEP.Primary.ClipSize 		= 20
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Spread 		= 0.1
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Recoil 		= 0
SWEP.Primary.Delay 			= 0.25
SWEP.Primary.Force 			= 10
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:PrimaryAttack() 
    if ( !self:CanPrimaryAttack() ) then return end 
 
    local bullet = {} 
        bullet.Num = self.Primary.NumberofShots 
        bullet.Src = self.Owner:GetShootPos() 
        bullet.Dir = self.Owner:GetAimVector() 
        bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0) 
        bullet.Tracer = 1 
        bullet.TracerName = "AirboatGunHeavyTracer"
        bullet.Force = self.Primary.Force 
        bullet.Damage = self.Primary.Damage 
        bullet.AmmoType = self.Primary.Ammo 
 
    local rnda = self.Primary.Recoil * -1 
    local rndb = self.Primary.Recoil * math.random(-1, 1) 
 
    self:ShootEffects() 
 
    self.Owner:FireBullets( bullet ) 
    self:EmitSound(Sound(self.Primary.Sound)) 
    self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
    self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
 
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay ) 
end