//////////////////////////////
//// Home Screen Enums
/////////////////////////////
enum HomeSection { chats, updates, calls, settings }

HomeSection getHomeSection(int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      return HomeSection.chats;

    case 1:
      return HomeSection.updates;

    case 2:
      return HomeSection.calls;

    case 3:
      return HomeSection.settings;

    default:
      return HomeSection.chats;
  }
}
