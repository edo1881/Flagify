/********************* Inizializzo le variabili per la struttura dello sfondo ***********************************************************************************/

var c = document.getElementById("c");
var w = c.width = window.innerWidth;
var h = c.height = window.innerHeight;
var context = c.getContext( '2d' );
var minDist = 10;
var maxDist = 30;
var initialWidth = 10;
var maxLines = 100;
var initialLines = 4;
var speed = 3;
var lines = [];
var frame = 0;
var timeSinceLast = 0;

var dirs = [
  [ 0, 1 ],
  [ 1, 0 ],
  [ 0, -1 ],
  [ -1, 0 ],

  [ .7, .7 ],
  [ .7, -.7 ],
  [ -.7, .7 ],
  [ -.7, -.7]
];

var starter = {
  x: w / 2,
  y: h / 2,
  vx: 0,
  vy: 0,
  width: initialWidth
};

/********************* Creo le prime linee ***********************************************************************************/

function init() {
  lines.length = 0; 
  for( var i = 0; i < initialLines; ++i )
    lines.push( new Line( starter ) );
  context.fillStyle = '#222';
  context.fillRect( 0, 0, w, h );
}

/********************* Modifica il colore ***********************************************************************************/

function getColor( x ) {
  return 'hsl( hue, 80%, 50% )'.replace('hue', x / w * 360 + frame);
}

/********************* Anima le linee ***********************************************************************************/

function anim() {
  window.requestAnimationFrame( anim );
  ++frame;
  context.shadowBlur = 0;
  context.fillStyle = 'rgba(0,0,0,.02)';
  context.fillRect( 0, 0, w, h );
  context.shadowBlur = .5;
  for( var i = 0; i < lines.length; ++i ) 
    if( lines[ i ].step() ) {
      lines.splice( i, 1 );
      --i;
    }
  ++timeSinceLast
  if( lines.length < maxLines && timeSinceLast > 10 && Math.random() < .5 ) {
    timeSinceLast = 0;
    lines.push( new Line( starter ) );
    // copre la parte centrale
    context.fillStyle = context.shadowColor = getColor( starter.x );
    context.beginPath();
    context.arc( starter.x, starter.y, initialWidth, 0, Math.PI * 2 );
    context.fill();
  }
}

/********************* Struttura della linea ***********************************************************************************/

function Line( parent ) {
  this.x = parent.x | 0;
  this.y = parent.y | 0;
  this.width = parent.width / 1.25;
  do {
    var dir = dirs[ ( Math.random() * dirs.length ) |0 ];
    this.vx = dir[ 0 ];
    this.vy = dir[ 1 ];
  } while ( 
    ( this.vx === -parent.vx && this.vy === -parent.vy ) || ( this.vx === parent.vx && this.vy === parent.vy) );
  this.vx *= speed;
  this.vy *= speed;
  this.dist = ( Math.random() * ( maxDist - minDist ) + minDist );
}

/********************* Fa muovere la linea, se esce dallo schermo, la toglie ************************************************************************/

Line.prototype.step = function() {
  var dead = false;
  var prevX = this.x;
  var prevY = this.y;
  this.x += this.vx;
  this.y += this.vy;

  --this.dist;

  // distrugge la linea se si trova fuori dallo schermo
  if( this.x < 0 || this.x > w || this.y < 0 || this.y > h )
    dead = true;

  // crea una linea figlio
  if( this.dist <= 0 && this.width > 1 ) {
    this.dist = Math.random() * ( maxDist - minDist ) + minDist;
    // aggiunge due figli
    if( lines.length < maxLines ) lines.push( new Line( this ) );
    if( lines.length < maxLines && Math.random() < .5 ) lines.push( new Line( this ) );
    if( Math.random() < .2 ) dead = true;
  }
  context.strokeStyle = context.shadowColor = getColor( this.x );
  context.beginPath();
  context.lineWidth = this.width;
  context.moveTo( this.x, this.y );
  context.lineTo( prevX, prevY );
  context.stroke();
  if( dead ) return true
}

init();
anim();

/********************* Riavvia lo sfondo in base alla dimensione della pagina ***********************************************************************************/

window.addEventListener( 'resize', function() {
  w = c.width = window.innerWidth;
  h = c.height = window.innerHeight;
  starter.x = w/2 ;
  starter.y = h/2;
  init();
});
