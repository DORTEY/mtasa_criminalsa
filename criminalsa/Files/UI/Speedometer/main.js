/*!
	*speedometer.js
	*author: Manivannan R
	*project: Speedometer
*/

var element;

function speedometer(userPref){
  element=this;
  
  this._speedometerProperty = {
    id                  : 'speedometer-cnt-' + Math.floor(Math.random() * 100000) + 1,  
                                              /**Speedometer container id*/
    maxVal              : 300,                /**Max value of the meter*/
    divFact             : 10,                 /**Division value of the meter*/
    dangerLevel         : 240,                /**more than this leval, color will be red*/
    initDeg             : -45,                /**reading begins angle*/
    maxDeg              : 270,                /**total angle of the meter reading*/
    
    speedNobeH          : 4,                  /**speed nobe height*/
    speedoNobeW         : 95,                 /**speed nobe width*/
    speedoNobeL         : 13,                 /**speed nobe left position*/
    
    edgeRadius          : 150,                /**radius of the meter circle*/
    indicatorRadius     : 125,                /**radius of indicators position*/
    indicatorNumbRadius : 90,                 /**radius of numbers position*/
    
    speedPositionTxtWH  : 80,                 /**speedo-meter current value cont*/
    
    nobW                : 20,                 /**indicator nob width*/
    nobH                : 4,                  /**indicator nob height*/
    
    numbW               : 20,                 /**indicator number width*/
    numbH               : 16,                 /**indicator number height*/
    
    midNobW             : 10,                 /**indicator mid nob width*/
    midNobH             : 3,                  /**indicator mid nob height*/
    
    noOfSmallDiv        : 3,                  /**no of small div between main div*/
    multiplier          : 1,                  /**Center value multiplier e.g. 1 x 1000 RPM*/	
    
    gagueLabel          : 'km/h',             /**Label on guage Face*/	
    
    initVal             : 0,                  /**Initial value*/
  };
  if(typeof userPref === 'object'){
    for (var prop in userPref) {
      this._speedometerProperty[prop] = userPref[prop];
    }
  }
  
  this.elm = null;
  
  this._noOfDev = this._speedometerProperty.maxVal/this._speedometerProperty.divFact;
  this._speedPointerArrow = null;
  this._speedValueInNumeric = null;
  this._speedNobNumbHolder = [];

  this._creatHtmlsElecments();
  this.setPosition(this._speedometerProperty.initVal);
}


speedometer.prototype._createElm = function(metedata) {

  function _isElementOrTxt(element) {
    return _isElement(element) || typeof element === 'string';
  }
  
  function _isElement(element) {
    return element instanceof Element || element instanceof HTMLDocument;
  }

  // if it is an dom element alredy, return as it is
  if (!metedata || _isElementOrTxt(metedata)) {
      return metedata;
  }

  var $elm = document.createElement(metedata.elmType);

  // Add attrs
  if (metedata.attrs) {
      for (var i in metedata.attrs) {
          $elm.setAttribute(i, metedata.attrs[i]);
      }
  }

  // add text
  if (metedata.text) $elm.innerText = metedata.text;

  // add raw html
  if (metedata.html) $elm.innerHTML = metedata.html;

  // add inner elemts recursively 
  if (metedata.children) {
      for (var j in metedata.children) {
          var chaild = this._createElm(metedata.children[j]);
          if(chaild){
            $elm.append(chaild);
          }
      }
  }

  //TODO : Event handlers

  return $elm;
};

speedometer.prototype._addClass = function (elm, className){
  var newClass = elm.getAttribute('class').replace(new RegExp(className, 'g'), '') + ' ' + className;
  elm.setAttribute('class', newClass);
};

speedometer.prototype._removeClass = function (elm, className){
  var newClass = elm.getAttribute('class').replace(new RegExp(className, 'g'), '');
  elm.setAttribute('class', newClass);
};

speedometer.prototype._creatHtmlsElecments = function(){
  this.elm = this._createElm({
    elmType: 'div',
    attrs:{
      id: this._speedometerProperty.id,
      class: 'speedometer'
    }
  });
  this._setCssProperty();
  this._createIndicators();
};

speedometer.prototype._setCssProperty = function() {
  
  var speedoWH       = this._speedometerProperty.edgeRadius*2,
  speedNobeTop       = this._speedometerProperty.edgeRadius - this._speedometerProperty.speedNobeH/2,
  speedNobeAngle     = this._speedometerProperty.initDeg,
  speedPositionTxtTL = this._speedometerProperty.edgeRadius - this._speedometerProperty.speedPositionTxtWH/2;
  
  var cssIdSelector = '#' + this._speedometerProperty.id;
  var tempStyleVar = [
    cssIdSelector + '.speedometer{',
      'width  :'+ speedoWH + 'vh;',
      'height :'+ speedoWH + 'vh;',
    '}',
    cssIdSelector + ' .speedNobe{',
      'height            :'+ this._speedometerProperty.speedNobeH + 'vh;',
      'top               :'+ speedNobeTop + 'vh;',
      'transform         :rotate('+speedNobeAngle+'deg);',
    '}',
    cssIdSelector + ' .speedPosition{',
      'width  :'+this._speedometerProperty.speedPositionTxtWH + 'vh;',
      'height :'+this._speedometerProperty.speedPositionTxtWH + 'vh;',
      'top  :'+speedPositionTxtTL + 'vh;',
      'left :'+speedPositionTxtTL + 'vh;',
    '}',
    cssIdSelector + ' .speedNobe div{',
      'width  :'+ this._speedometerProperty.speedoNobeW + 'vh;',
      'left :'+ this._speedometerProperty.speedoNobeL + 'vh;',
    '}',      
    cssIdSelector + ' .nob{',
      'width  :'+ this._speedometerProperty.nobW + 'vh;',
      'height :'+ this._speedometerProperty.nobH + 'vh;',
    '}',
    cssIdSelector + ' .numb{',
      'width  :'+ this._speedometerProperty.numbW + 'vh;',
      'height :'+ this._speedometerProperty.numbH + 'vh;',
    '}',
    cssIdSelector + ' .midNob{',
      'width  :'+ this._speedometerProperty.midNobW + 'vh;',
      'height :'+ this._speedometerProperty.midNobH + 'vh;',
    '}',
  ].join('');

  var styleElm = this._createElm({
    elmType: 'style',
    attrs:{},
    html: tempStyleVar
  });

  this.elm.append(styleElm);    
};

speedometer.prototype._createIndicators = function(){
  var divDeg = this._speedometerProperty.maxDeg/this._noOfDev,
  induCatorLinesPosLeft,induCatorLinesPosTop,induCatorNumbPosLeft,induCatorNumbPosTop,
  envelopeElm = this.elm;

  for(var i=0; i<=this._noOfDev; i++) {
    var curDig = this._speedometerProperty.initDeg + i*divDeg;
    var curIndVal = i*this._speedometerProperty.divFact;
    var dangCls = curIndVal >= this._speedometerProperty.dangerLevel ? "danger" : "";
    
    var induCatorLinesPosY = this._speedometerProperty.indicatorRadius * Math.cos( 0.01746 * curDig);
    var induCatorLinesPosX = this._speedometerProperty.indicatorRadius * Math.sin( 0.01746 * curDig);
    
    var induCatorNumbPosY = this._speedometerProperty.indicatorNumbRadius * Math.cos( 0.01746 * curDig);
    var induCatorNumbPosX = this._speedometerProperty.indicatorNumbRadius * Math.sin( 0.01746 * curDig);
    
    induCatorNumbPosLeft = (this._speedometerProperty.edgeRadius - induCatorNumbPosX) - (this._speedometerProperty.numbW/2);
    induCatorNumbPosTop  = (this._speedometerProperty.edgeRadius - induCatorNumbPosY) - (this._speedometerProperty.numbH/2);

    var nob, numb;

    var isSuperNob = i%this._speedometerProperty.noOfSmallDiv === 0; 

    if(isSuperNob){
      induCatorLinesPosLeft = (this._speedometerProperty.edgeRadius - induCatorLinesPosX )-2;
      induCatorLinesPosTop  = (this._speedometerProperty.edgeRadius - induCatorLinesPosY)-10;
      induCatorNumbPosLeft = (this._speedometerProperty.edgeRadius - induCatorNumbPosX) - (this._speedometerProperty.numbW/2);
      induCatorNumbPosTop  = (this._speedometerProperty.edgeRadius - induCatorNumbPosY) - (this._speedometerProperty.numbH/2);
    } else {
      induCatorLinesPosLeft = (this._speedometerProperty.edgeRadius - induCatorLinesPosX )-(this._speedometerProperty.midNobH/2);
      induCatorLinesPosTop = (this._speedometerProperty.edgeRadius - induCatorLinesPosY)-(this._speedometerProperty.midNobW/2);
    }

    nob = this._createElm({
      elmType: 'div',
      attrs: {
        class: "nob "+ dangCls + (isSuperNob? '' : ' midNob'),
        style: "left:"+induCatorLinesPosTop+"vh;top:"+induCatorLinesPosLeft+"vh;"+'transform:rotate('+curDig+'deg);'
      }
    });

    numb = this._createElm({
      elmType: 'div',
      attrs: {
        class: "numb "+dangCls,
        style: "left:" + induCatorNumbPosTop + "vh;top:" + induCatorNumbPosLeft + "vh;"
      },
      html: isSuperNob ? String(curIndVal) : '' // mid nob does not have text
    });

    this._speedNobNumbHolder.push({
      nob  : nob,
      numb : numb
    });

    // Speed indicators arround the circle
    envelopeElm.append(nob, numb);

  }
  
  // Speed pointer arrow 
  this._speedPointerArrow = this._createElm({
    elmType: 'div',
    attrs: {
      class: 'speedNobe'
    },
    html: '<div></div>'
  });

  // Speed value indicator at the center
  this._speedValueInNumeric = this._createElm({
    elmType: 'div',
    attrs: {
      class: 'speedPosition'
    }
  });

  envelopeElm.append(this._speedPointerArrow);
  envelopeElm.append(this._speedValueInNumeric);
  
};

speedometer.prototype.setPosition = function (speed){   

  if(speed > this._speedometerProperty.maxVal){
    speed = this._speedometerProperty.maxVal;
  }
  if(speed < 0 || isNaN(speed)){
    speed = 0;
  }
  var speedInDeg = (this._speedometerProperty.maxDeg/this._speedometerProperty.maxVal)*speed + this._speedometerProperty.initDeg;
  
  // Set Speed arrow indigator position
  this._speedPointerArrow.style.transform = 'rotate('+speedInDeg+'deg)';
  
  // Set Speed value at the center of speedometer
  var centerVal = speed *  this._speedometerProperty.multiplier;
  this._speedValueInNumeric.innerHTML = centerVal + "<br />" + this._speedometerProperty.gagueLabel;

  // Set indicator nob and number brightness value
  for(var i=0; i<=this._noOfDev; i++){
    var speedNobNumb = this._speedNobNumbHolder[i];
    if(speed >= i*this._speedometerProperty.divFact){
      this._addClass(speedNobNumb.nob, 'bright');
      this._addClass(speedNobNumb.numb, 'bright');
    }else{
      this._removeClass(speedNobNumb.nob, 'bright');
      this._removeClass(speedNobNumb.numb, 'bright');
    }
  }
};


var speedoMeter = new speedometer();
document.getElementById('speedometer').append(speedoMeter.elm);

var speedoMeterInputRange = document.getElementById('speedoMeterInputRange-1');
var speedoMeterInputRangeVal = document.getElementById('speedoMeterInputRange-value-1');

speedoMeterInputRange.onchange = function(e){
  speedoMeter.setPosition(e.target.value);
  speedoMeterInputRangeVal.innerText = e.target.value;
}









function showSpeedo(speed){
    var dangerLevel=element._speedometerProperty.dangerLevel;

    if(speed>=dangerLevel){
      $(".speedometer .speedNobe div").css("background","#FF113A");
      $(".speedometer .speedPosition").css("color","#FF113A");
    }else{
      $(".speedometer .speedNobe div").css("background","rgba(200,200,200,1)");
      $(".speedometer .speedPosition").css("color","rgba(200,200,200,1)");
    }

    speedoMeter.setPosition(speed);
    speedoMeterInputRangeVal.innerText=speed;
}
