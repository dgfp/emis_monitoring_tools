var map = L.map('map').setView([latitude, longitude], zoom);

//background world map
//         L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
//                maxZoom: 18,
//                attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
//                        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
//                        'Imagery © <a href="http://mapbox.com">Mapbox</a>',
//                id: 'mapbox.light'
//         }).addTo(map);



// control that shows state infos on hover
var infos = L.control();

zoom = map.getZoom();

infos.onAdd = function (map) {
    this._div = L.DomUtil.create('div', 'infos');
    this.update();
    return this._div;
};

infos.update = function (props) {
    this._div.innerHTML = '<h4>NID Registration Coverage.</h4>' +  (props ?
            '<b>' + props.name + '</b><br />'+shows+': ' + props.percentage + '  %cc'
            : 'Hover over a state');
};

infos.addTo(map);


// get color depending on population density value
// -----------Blue
//function getColor(d) {
//    return d > 100  ? '#023858' :
//                d > 90  ? '#045a8d' :
//                d > 80  ? '#0570b0' :
//                d > 70   ? '#3690c0' :
//                d > 60   ? '#6bc2e8' :
//                d > 50   ? '#91d9f2' :
//                d > 40   ? '#ace8f9' :
//                d > 30   ? '#caf0f9' :
//                d > 20   ? '#e4f6f9' :
//                d > 10   ? '#f7fcfc' :
//                'white';
//}

//Orange
function getColor(d) {
    return d > 100  ? '#82415a' :
                d > 90  ? '#a34a64' :
                d > 80  ? '#ce4a64' :
                d > 70   ? '#e85c5d' :
                d > 60   ? '#fa8067' :
                d > 50   ? '#fbac74' :
                d > 40   ? '#fbc67f' :
                d > 30   ? '#fbe19c' :
                d > 20   ? '#fcefba' :
                d > 10   ? '#f9f5e4' :
                'white';
}

function style(feature) {
    return {
            weight: 2,
            opacity: 1,
            color: '#032b3f',
            dashArray: '2',
            fillOpacity: 0.7,
            fillColor: getColor(feature.properties.percentage)
    };
}

function highlightFeature(e) {
    var layer = e.target;

    layer.setStyle({
            weight: 3,
            color: '#666',
            dashArray: '',
            fillOpacity: 0.7
    });

    if (!L.Browser.ie && !L.Browser.opera && !L.Browser.edge) {
            layer.bringToFront();
    }

    infos.update(layer.feature.properties);
}

var geojson;

function resetHighlight(e) {
    geojson.resetStyle(e.target);
    infos.update();
}

function zoomToFeature(e) {
    //map.fitBounds(e.target.getBounds());
    alert("Drill down will goes here");
}

function onEachFeature(feature, layer) {
    layer.on({
            mouseover: highlightFeature,
            mouseout: resetHighlight,
            click: zoomToFeature
    });
}

geojson = L.geoJson(statesData, {
    style: style,
    onEachFeature: onEachFeature
}).addTo(map);

map.attributionControl.addAttribution('Map data &copy; <a href="http://rhis.net.bd/" target="_blank">eMIS</a>');

var legend = L.control({position: 'bottomright'});

legend.onAdd = function (map) {

    var div = L.DomUtil.create('div', 'infos legend'),
            grades = [1,10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
            labels = [],
            from, to;

//old
//    for (var i = 0; i < grades.length; i++) {
//            from = grades[i];
//            to = grades[i + 1];
//
//            labels.push(
//                    '<i style="background:' + getColor(from + 1) + '"></i> ' +
//                    from + (to ? '&ndash;' + to : '+'));
//    }

//modified
    for (var i = 0; i < grades.length-1; i++) {
            from = grades[i];
            to = grades[i + 1];

            labels.push(
                    '<i style="background:' + getColor(from + 1) + '"></i> ' +
                    from + (to ? '&ndash;' + to : ''));
    }

    div.innerHTML = labels.join('<br>');
    return div;
};

legend.addTo(map);
