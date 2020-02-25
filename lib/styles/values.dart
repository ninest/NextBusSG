
class Values {
  /*
  used below titles
  used above tiles (such as bus stop tiles on main page)
  */
  static final double marginBelowTitle = 15;

  /*
  basic font size
  used in search boxes and buttons mainly
  */
  static final double em = 18;


  /* 
  padding values for bus stop tiles
    - loading tiles
    - search result tiles

  hope to use it for
    - expansion tile
  
  I don't know how to change the default inner padding of expansion tiles.
  These values below have been 'eye-balled'. They look fine
  */
  static final double busStopTileHorizontalPadding = 16;
  static final double busStopTileVerticalPadding = em;

  // static final double busServiceTildHorizontalPadding = 18;
  // static final double busServiceTildVerticalPadding = 18;
  static final double busServiceTilePadding = 18;


  /*
  this is the borderRadius for the expansion tile
  all values can be either more or less than it
  (ex: bus stop tile should be less than it)
  */
  static final double borderRadius = 10;
}