/*
(function() {
	var control = new L.Control({position:'topright'});
	control.onAdd = function(map) {
			var azoom = L.DomUtil.create('a','resetzoom');
			azoom.innerHTML = "[Reset Zoom]";
			L.DomEvent
				.disableClickPropagation(azoom)
				.addListener(azoom, 'click', function() {
					map.setView(map.options.center, map.options.zoom);
				},azoom);
			return azoom;
		};
	return control;
}())
.addTo(map);

*/


/*
L.Map.include({
  'clearLayers': function () {
    this.eachLayer(function (layer) {
      this.removeLayer(layer);
    }, this);
  }
});
 */