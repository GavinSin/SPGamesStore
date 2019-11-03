/*!
 * @fileOverview cardSlider - jQuery Plugin
 * @version 1.0.0
 *
 * @author Jerome Dupuis
 * @see https://gitlab.apdev.jp/browser-js-plugins/card-slider
 * Copyright (c) 2017 Altpluc inc.
 * Any reproduction is prohibited.
 */

try{!function(i){"use strict";if(void 0===i)throw new Error("jQuery plugin is missing");var t={slideTag:"div",slideClass:null,current:1,onBeforeMove:null,onAfterMove:null,onMove:null,onInit:null,onCurrent:null,followingClass:null,delay:null,transition:null};i.fn.cardSlider=function(s){var n=this;return this.params=i.extend({},t,s||{}),this.slider=i(this),this.slides=[],this.count=0,this.current=this.params.current||1,this.transitionEvent=null,this.init=function(){this.transitionEvent=n.whichTransitionEvent(),this.setSlides(),this.setSlidesTransition(),this.setSlideIndexes(),this.setWheeling(),this.setSlideClasses(),this.setNavEvents(),this.followContent(),this.callFunction(this.params.onInit)},this.setNavEvents=function(){this.slider.delegate(".right-slide","click",function(){return n.next(),!1}),this.slider.delegate(".left-slide","click",function(){return n.prev(),!1}),this.slider.delegate(".center-slide","click",function(){return n.callFunction(n.params.onCurrent),!1})},this.setSlides=function(){this.params.slideClass?this.slides=this.slider.find(this.params.slideTag+"."+this.params.slideClass):this.slides=this.slider.find(this.params.slideTag),this.count=this.slides.length},this.setSlideIndexes=function(){var t=0;this.slides.each(function(){i(this).attr("data-index",t).data("index",t),t++})},this.resetSlideClasses=function(){this.slides.removeClass("left-hidden-slide left-slide center-slide right-slide right-hidden-slide").addClass("hidden-slide")},this.setSlideClasses=function(){this.resetSlideClasses();var i={"-2":"left-hidden-slide","-1":"left-slide",0:"center-slide",1:"right-slide",2:"right-hidden-slide"},t=0;for(var s in i)if(!(t+1>this.count)){var n=i[s],e=this.getSlidePosition(s);e&&e.addClass(n).removeClass("hidden-slide"),t++}},this.setSlidesTransition=function(){if(!this.slides||!this.slides.length)throw new Error("Slides is missing");null!==this.params.delay&&this.slides.each(function(){i(this).css({transitionDuration:n.params.delay+"ms",webkitTransitionDuration:n.params.delay+"ms"})}),null!==this.params.transition&&this.slides.each(function(){i(this).css({transitionTimingFunction:n.params.transition,webkitTransitionTimingFunction:n.params.transition})})},this.getIndexPosition=function(i){var t=parseInt(this.current)+parseInt(i);return t>=this.count?t-=this.count:t<=0&&(t=this.count+t),t},this.getSlidePosition=function(i){var t=this.getIndexPosition(i),s=this.getIndex(t),n=this.getSlideByIndex(s);return n},this.setWheeling=function(){if(1==this.count||this.count>5)return!1;var i=this.getSlideByIndex(this.getIndex(1));if(i){var t=i.clone(!0);this.slider.append(t)}var i=this.getSlideByIndex(this.getIndex(2));if(i){var t=i.clone(!0);this.slider.append(t)}if(2==this.count){var i=this.getSlideByIndex(this.getIndex(1));if(i){var t=i.clone(!0);this.slider.append(t)}var i=this.getSlideByIndex(this.getIndex(2));if(i){var t=i.clone(!0);this.slider.append(t)}}if(this.count>=3){var i=this.getSlideByIndex(this.getIndex(3));if(i){var t=i.clone(!0);this.slider.append(t)}if(this.count>=4){var i=this.getSlideByIndex(this.getIndex(4));if(i){var t=i.clone(!0);this.slider.append(t)}}if(this.count>=5){var i=this.getSlideByIndex(this.getIndex(5));if(i){var t=i.clone(!0);this.slider.append(t)}}}this.setSlides()},this.getSlideByIndex=function(t){if(!this.slides||!this.slides.length)throw new Error("Slides is missing");var s=i(this.slides.get(t));return s&&s.length?s:null},this.getCurrentSlide=function(){return this.getSlideByIndex(this.getIndex(this.current))},this.afterMoveHandler=function(){n.callFunction(n.params.onAfterMove)},this.moveHandler=function(){if(n.setSlideClasses(),n.hasFunction(n.params.onMove)?n.callFunction(n.params.onMove,n.afterMoveHandler):n.afterMoveHandler(),n.hasFunction(n.params.onAfterTransition)){var i=n.getCurrentSlide();i.one(n.transitionEvent,function(i){n.callFunction(n.params.onAfterTransition)})}n.followContent()},this.move=function(){0==this.current?this.current=this.count:this.current>this.count&&(this.current=1),this.hasFunction(this.params.onBeforeMove)?this.callFunction(this.params.onBeforeMove,this.moveHandler):this.moveHandler()},this.next=function(){this.current++,this.move()},this.prev=function(){this.current--,this.move()},this.followContent=function(){if(this.params.followingClass){i("."+this.params.followingClass).hide();var t=this.getSlideByIndex(this.getIndex(this.current));if(t){var s=t.data("index");i("."+this.params.followingClass+'[data-index="'+s+'"]').show()}}},this.hasFunction=function(i){return!(!i||"function"!=typeof i)},this.callFunction=function(i,t){this.hasFunction(i)&&i(this,t)},this.getIndex=function(i){var i=i-1;return i},this.getPercent=function(i,t){var i=parseFloat(i);return parseFloat(i)/100*t},this.whichTransitionEvent=function(){var i,t=document.createElement("transitionCheckElement"),s={transition:"transitionend",OTransition:"oTransitionEnd",MozTransition:"transitionend",WebkitTransition:"webkitTransitionEnd"};for(i in s)if(void 0!==t.style[i])return s[i]},this.init(),this}}(jQuery)}catch(i){console.log(i)}finally{}