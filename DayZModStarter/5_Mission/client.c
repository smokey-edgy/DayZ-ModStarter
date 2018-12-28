modded class MissionGameplay
{
  void MissionGameplay()
  {

  }

  override void TickScheduler(float timeslice)
  {
    /* This code runs on the client and should show a system message saying 'Tick'.
       This will prove your client side code is running properly. */
    GetGame().ChatPlayer(1, "Tick");
  }
}
