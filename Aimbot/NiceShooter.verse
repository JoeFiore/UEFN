

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

AimBot := class(creative_device):
    @editable AimDevice : gameplay_controls_third_person_device = gameplay_controls_third_person_device{}
    @editable AimbotLengthTime : float = 0.0
    @editable AimBotSound : audio_player_device = audio_player_device{}

    @editable Cooldown : float = 0.0
    var MaybeCooldown : logic = false
    @editable AimbotTimer : timer_device = timer_device{}
    @editable CooldownMSG : hud_message_device = hud_message_device{}


    OnBegin<override>()<suspends>:void=
        AimbotTimer.SetMaxDuration(Cooldown)
        set MaybeCooldown = false
        AimbotTimer.SuccessEvent.Subscribe(ResetCooldown)
    BeginAimbot(Agent:agent)<suspends> : void=
        if(MaybeCooldown = false):
            AimbotTimer.Start(Agent)
            set MaybeCooldown=true

            AimBotSound.Play(Agent)
            AimDevice.Enable()
            AimDevice.AddTo(Agent)

            Sleep(AimbotLengthTime)

            AimDevice.RemoveFrom(Agent)
            AimDevice.Disable()
        else:
            CooldownMSG.Show(Agent)

    ResetCooldown(Agent:?agent) : void=
        set MaybeCooldown = false
