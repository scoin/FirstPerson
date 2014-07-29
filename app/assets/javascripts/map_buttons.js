var newMarkers;
var oldMarkers;
var handler;
var geolocation;

function updateMap() {
  handler.removeMarkers(oldMarkers);
  oldMarkers = handler.addMarkers(newMarkers);
  handler.bounds.extendWith(oldMarkers);
  handler.fitMapToBounds();
}

$(document).ready(function() {

  $("#show_user_quests").hide();
  $("#show_active_quests").click(function() {
    $("#show_user_quests").slideDown()
  });

  // Preloading data FTW!
  $("#show_user_checkins").mouseenter(function() {
    $.getJSON('/users/checkins', function(data) {
      newMarkers = data
    })
  });
  $("#show_user_checkins").mousedown(function() {
    updateMap();
  });

  $("#show_all_quests").mouseenter(function() {
    $.getJSON('/quests/all', function(data) {
      newMarkers = data
    })
  });
  $("#show_all_quests").click(function() {
    updateMap();
  });

  $("#show_completed_quests").mouseenter(function() {
    $.getJSON('/quests/completed', function(data) {
      newMarkers = data
    })
  });
  $("#show_completed_quests").click(function() {
    updateMap();
  });
});