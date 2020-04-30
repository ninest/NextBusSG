class Values {
  /*
  used below titles
  used above tiles (such as bus stop tiles on main page)
  */
  static double get marginBelowTitle => 15;

  /*
  basic font size
  used in search boxes and buttons mainly
  */
  static double get em => 17;

  /*
  padding for main pageTemplate
  */
  static double get pageHorizontalPadding => 18;

  /* 
  padding values for bus stop tiles
    - loading tiles
    - search result tiles

  hope to use it for
    - expansion tile
  
  I don't know how to change the default inner padding of expansion tiles.
  These values below have been 'eye-balled'. They look fine
  */
  static double get busStopTileHorizontalPadding => 16;
  static double get busStopTileVerticalPadding => em;

  static double get busServiceTilePadding => 18;

  /*
  this is the borderRadius for the expansion tile
  all values can be either more or less than it
  (ex: bus stop tile should be less than it)
  */
  static double get borderRadius => 10;

  // container opacity
  /*
  this is used in mrt page, timings not available container
   */
  static double get containerOpacity => 0.2;
}
