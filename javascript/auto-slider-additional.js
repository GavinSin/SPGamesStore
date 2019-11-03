/*!
 * @fileOverview auto-click - additional card slider plugin
 * @version 1.0.0
 *
 * @author Gavin Sin Fu Chen
 * Any reproduction is prohibited.
 */

//Initialise  the card-slider variables
window.slider = $('#slider').cardSlider({
  slideTag: 'div'
  , slideClass: 'slide'
  , current: 1
  , followingClass: 'slider-content-6'
  , delay: 300
  , transition: 'ease'
  , onBeforeMove: function(slider, onMove) {
	console.log('onBeforeMove')
	onMove()
  }
  , onMove: function(slider, onAfterMove) {
	onAfterMove()
  }
  , onAfterMove: function() {
	console.log('onAfterMove')
  }
  , onAfterTransition: function() {
	console.log('onAfterTransition')
  }
  , onCurrent: function() {
	console.log('onCurrent')
  }  
})

// Get the classname of the photo on right hand slide
var rightslide = document.getElementsByClassName("right-slide");
// Click the right hand slide evey 6 seconds
setInterval(
	() => $( rightslide ).trigger("click"),
	5000
);