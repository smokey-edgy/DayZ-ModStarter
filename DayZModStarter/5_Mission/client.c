modded class MissionGameplay
{
  void MissionGameplay()
  {

  }

  override void TickScheduler(float timeslice)
  {
    GetGame().ChatPlayer(1, "Tick");
  }
}
