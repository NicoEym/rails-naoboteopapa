import "bootstrap";
import { initMapbox } from '../plugins/init_mapbox';


const mapElement = document.getElementById('map');
  if (mapElement){
    initMapbox();
  };


