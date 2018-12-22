class CfgPatches
{
  class DayZModStarter
  {
    units[]={};
    weapons[]={};
    requiredVersion=0.1;
    requiredAddons[]={};
  };
};

class CfgMods
{
  class DayZModStarter
  {
    dir = "DayZModStarter";
    picture = "";
    action = "";
    hideName = 1;
    hidePicture = 1;
    name = "DayZ Mod Starter";
    credits = "Smoke";
    author = "Smoke";
    authorID = "0";
    version = "0.1";
    extra = 0;
    type = "mod";

    dependencies[] = { "Mission" };

    class defs
    {
      class gameScriptModule
      {
        value = "";
        files[] = {"DayZModStarter/3_Game"};
      };

      class worldScriptModule
      {
        value = "";
        files[] = {"DayZModStarter/4_World"};
      };

      class missionScriptModule
      {
        value = "";
        files[] = {"DayZModStarter/5_Mission"};
      };
    };
  };
};
