using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }

custom_weapon_damage := class(creative_device):

    @editable CustomDamageCB : conditional_button_device = conditional_button_device {} 
    @editable DamageMultiplierValue : float = 0.0

    HandlePlayerHit( DamageResult : damage_result ) : void =
        if:
            Target := DamageResult.Target
            Amount := DamageResult.Amount
            DamageMultiplier :float = DamageMultiplierValue
            Instigator := DamageResult.Instigator?
            InstigatorAgent := Instigator.GetInstigatorAgent[]
            InstigatorFort := InstigatorAgent.GetFortCharacter[]
            InstigatorPlayer := player[InstigatorAgent]
            CharacterWhoWasHitFort := fort_character[Target]
            CharacterWhoWasHitAgent := CharacterWhoWasHitFort.GetAgent[]
            CharacterWhoWasHitPlayer := player[CharacterWhoWasHitAgent]
            if(CustomDamageCB.IsHoldingItem[InstigatorPlayer]):

        then:
            if (InstigatorAgent = CharacterWhoWasHitAgent):

            else:
                CharacterWhoWasHitFort.Damage(Amount * DamageMultiplier)
  
    OnPlayerAdded (InPlayer : player) : void=
        if (FortCharacter := InPlayer.GetFortCharacter[]):
            FortCharacter.DamagedEvent().Subscribe(HandlePlayerHit)
            FortCharacter.DamagedShieldEvent().Subscribe(HandlePlayerHit)

    OnBegin<override>()<suspends>:void=
        for (Player : GetPlayspace().GetPlayers(), FortCharacter := Player.GetFortCharacter[]):
            FortCharacter.DamagedEvent().Subscribe(HandlePlayerHit)
            FortCharacter.DamagedShieldEvent().Subscribe(HandlePlayerHit)
            GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)




#|MINERVA SOCIALS:
#|https://discord.gg/MRV	
#|https://www.youtube.com/@MinervaUefn
