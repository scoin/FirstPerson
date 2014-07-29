var Map = {
  lines: [],
  newMarkers: null,
  oldMarkers: null,
  handler: null
}

Map.removePolylines = function() {
  for (var i = 0; i < this.lines.length; i++ ) {
    this.lines[i].setMap();
  }
}

Map.updateMap = function() {
  this.removePolylines()
  this.handler.removeMarkers(this.oldMarkers);
  this.oldMarkers = this.handler.addMarkers(this.newMarkers);
  this.handler.bounds.extendWith(this.oldMarkers);
  this.handler.fitMapToBounds();
}

Map.createMap = function() {
  self = this
  this.handler = Gmaps.build('Google');
  this.handler.buildMap({ internal: {id: 'map'} }, function(){
    if(navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(self.displayMap);
    }
  });
}

Map.displayMap = function(position){
  self = Map
  mark = self.handler.addMarker({
    lat: position.coords.latitude,
    lng: position.coords.longitude
  });
  self.handler.map.centerOn(mark);
  self.handler.removeMarker(mark);
 };

$(document).ready(function() {
  Map.createMap();
});