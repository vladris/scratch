!function(t){function e(n){if(r[n])return r[n].exports;var o=r[n]={i:n,l:!1,exports:{}};return t[n].call(o.exports,o,o.exports,e),o.l=!0,o.exports}var r={};e.m=t,e.c=r,e.d=function(t,r,n){e.o(t,r)||Object.defineProperty(t,r,{configurable:!1,enumerable:!0,get:n})},e.n=function(t){var r=t&&t.__esModule?function(){return t.default}:function(){return t};return e.d(r,"a",r),r},e.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},e.p="",e(e.s=10)}([function(t,e){function r(){throw new Error("setTimeout has not been defined")}function n(){throw new Error("clearTimeout has not been defined")}function o(t){if(s===setTimeout)return setTimeout(t,0);if((s===r||!s)&&setTimeout)return s=setTimeout,setTimeout(t,0);try{return s(t,0)}catch(e){try{return s.call(null,t,0)}catch(e){return s.call(this,t,0)}}}function i(t){if(l===clearTimeout)return clearTimeout(t);if((l===n||!l)&&clearTimeout)return l=clearTimeout,clearTimeout(t);try{return l(t)}catch(e){try{return l.call(null,t)}catch(e){return l.call(this,t)}}}function u(){y&&p&&(y=!1,p.length?v=p.concat(v):h=-1,v.length&&c())}function c(){if(!y){var t=o(u);y=!0;for(var e=v.length;e;){for(p=v,v=[];++h<e;)p&&p[h].run();h=-1,e=v.length}p=null,y=!1,i(t)}}function a(t,e){this.fun=t,this.array=e}function f(){}var s,l,d=t.exports={};!function(){try{s="function"==typeof setTimeout?setTimeout:r}catch(t){s=r}try{l="function"==typeof clearTimeout?clearTimeout:n}catch(t){l=n}}();var p,v=[],y=!1,h=-1;d.nextTick=function(t){var e=new Array(arguments.length-1);if(arguments.length>1)for(var r=1;r<arguments.length;r++)e[r-1]=arguments[r];v.push(new a(t,e)),1!==v.length||y||o(c)},a.prototype.run=function(){this.fun.apply(null,this.array)},d.title="browser",d.browser=!0,d.env={},d.argv=[],d.version="",d.versions={},d.on=f,d.addListener=f,d.once=f,d.off=f,d.removeListener=f,d.removeAllListeners=f,d.emit=f,d.prependListener=f,d.prependOnceListener=f,d.listeners=function(t){return[]},d.binding=function(t){throw new Error("process.binding is not supported")},d.cwd=function(){return"/"},d.chdir=function(t){throw new Error("process.chdir is not supported")},d.umask=function(){return 0}},function(t,e,r){"use strict";function n(t,e,r){function c(){b===h&&(b=h.slice())}function a(){return y}function f(t){if("function"!=typeof t)throw new Error("Expected listener to be a function.");var e=!0;return c(),b.push(t),function(){if(e){e=!1,c();var r=b.indexOf(t);b.splice(r,1)}}}function s(t){if(!Object(o.a)(t))throw new Error("Actions must be plain objects. Use custom middleware for async actions.");if(void 0===t.type)throw new Error('Actions may not have an undefined "type" property. Have you misspelled a constant?');if(O)throw new Error("Reducers may not dispatch actions.");try{O=!0,y=v(y,t)}finally{O=!1}for(var e=h=b,r=0;r<e.length;r++){(0,e[r])()}return t}function l(t){if("function"!=typeof t)throw new Error("Expected the nextReducer to be a function.");v=t,s({type:u.INIT})}function d(){var t,e=f;return t={subscribe:function(t){function r(){t.next&&t.next(a())}if("object"!=typeof t)throw new TypeError("Expected the observer to be an object.");return r(),{unsubscribe:e(r)}}},t[i.a]=function(){return this},t}var p;if("function"==typeof e&&void 0===r&&(r=e,e=void 0),void 0!==r){if("function"!=typeof r)throw new Error("Expected the enhancer to be a function.");return r(n)(t,e)}if("function"!=typeof t)throw new Error("Expected the reducer to be a function.");var v=t,y=e,h=[],b=h,O=!1;return s({type:u.INIT}),p={dispatch:s,subscribe:f,getState:a,replaceReducer:l},p[i.a]=d,p}r.d(e,"a",function(){return u}),e.b=n;var o=r(2),i=r(21),u={INIT:"@@redux/INIT"}},function(t,e,r){"use strict";function n(t){if(!Object(u.a)(t)||Object(o.a)(t)!=c)return!1;var e=Object(i.a)(t);if(null===e)return!0;var r=l.call(e,"constructor")&&e.constructor;return"function"==typeof r&&r instanceof r&&s.call(r)==d}var o=r(13),i=r(18),u=r(20),c="[object Object]",a=Function.prototype,f=Object.prototype,s=a.toString,l=f.hasOwnProperty,d=s.call(Object);e.a=n},function(t,e,r){"use strict";var n=r(14),o=n.a.Symbol;e.a=o},function(t,e){var r;r=function(){return this}();try{r=r||Function("return this")()||(0,eval)("this")}catch(t){"object"==typeof window&&(r=window)}t.exports=r},function(t,e,r){"use strict";function n(t){"undefined"!=typeof console&&"function"==typeof console.error&&console.error(t);try{throw new Error(t)}catch(t){}}e.a=n},function(t,e,r){"use strict";function n(){for(var t=arguments.length,e=Array(t),r=0;r<t;r++)e[r]=arguments[r];return 0===e.length?function(t){return t}:1===e.length?e[0]:e.reduce(function(t,e){return function(){return t(e.apply(void 0,arguments))}})}e.a=n},function(t,e,r){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var n={SORT_COLORS:"SORT_COLORS",ADD_COLOR:"ADD_COLOR",RATE_COLOR:"RATE_COLOR",REMOVE_COLOR:"REMOVE_COLOR"};e.default=n},function(t,e){var r="undefined"!=typeof crypto&&crypto.getRandomValues.bind(crypto)||"undefined"!=typeof msCrypto&&msCrypto.getRandomValues.bind(msCrypto);if(r){var n=new Uint8Array(16);t.exports=function(){return r(n),n}}else{var o=new Array(16);t.exports=function(){for(var t,e=0;e<16;e++)0==(3&e)&&(t=4294967296*Math.random()),o[e]=t>>>((3&e)<<3)&255;return o}}},function(t,e){function r(t,e){var r=e||0,o=n;return o[t[r++]]+o[t[r++]]+o[t[r++]]+o[t[r++]]+"-"+o[t[r++]]+o[t[r++]]+"-"+o[t[r++]]+o[t[r++]]+"-"+o[t[r++]]+o[t[r++]]+"-"+o[t[r++]]+o[t[r++]]+o[t[r++]]+o[t[r++]]+o[t[r++]]+o[t[r++]]}for(var n=[],o=0;o<256;++o)n[o]=(o+256).toString(16).substr(1);t.exports=r},function(t,e,r){"use strict";var n=r(11),o=function(t){return t&&t.__esModule?t:{default:t}}(n),i=r(28),u=(0,o.default)();u.dispatch((0,i.addColor)("#FFFFFF","Bright White")),u.dispatch((0,i.addColor)("#00FF00","Lawn")),u.dispatch((0,i.addColor)("#0000FF","Big Blue"))},function(t,e,r){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var n=r(12),o=r(27),i={colors:[{id:"3315e1p5-3abl-0p523-30e4-8001l8yf3036",title:"Rad Red",color:"#FF0000",rating:3,timestamp:"Sat Mar 12 2016 16:12:09 GMT-0800 (PST)"},{id:"3315e1p5-3abl-0p523-30e4-8001l8yf4457",title:"Crazy Green",color:"#00FF00",rating:0,timestamp:"Fri Mar 11 2016 12:00:00 GMT-0800 (PST)"},{id:"3315e1p5-3abl-0p523-30e4-8001l8yf2412",title:"Big Blue",color:"#0000FF",rating:5,timestamp:"Thu Mar 10 2016 01:11:12 GMT-0800 (PST)"}],sort:"SORTED_BY_TITLE"},u=function(t){return function(e){return function(r){console.groupCollapsed("dispatching",r.type),console.log("prev state",t.getState()),console.log("action",r),e(r),console.log("next state",t.getState()),console.groupEnd()}}},c=function(t){return function(e){return function(r){var n=e(r);return localStorage["redux-store"]=JSON.stringify(t.getState()),n}}},a=function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:i;return(0,n.applyMiddleware)(u,c)(n.createStore)((0,n.combineReducers)({colors:o.colors,sort:o.sort}),localStorage["redux-store"]?JSON.parse(localStorage["redux-store"]):t)};e.default=a},function(t,e,r){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),function(t){function n(){}var o=r(1),i=r(24),u=r(25),c=r(26),a=r(6),f=r(5);r.d(e,"createStore",function(){return o.b}),r.d(e,"combineReducers",function(){return i.a}),r.d(e,"bindActionCreators",function(){return u.a}),r.d(e,"applyMiddleware",function(){return c.a}),r.d(e,"compose",function(){return a.a}),"production"!==t.env.NODE_ENV&&"string"==typeof n.name&&"isCrushed"!==n.name&&Object(f.a)("You are currently using minified code outside of NODE_ENV === 'production'. This means that you are running a slower development build of Redux. You can use loose-envify (https://github.com/zertosh/loose-envify) for browserify or DefinePlugin for webpack (http://stackoverflow.com/questions/30030031) to ensure you have the correct code for your production build.")}.call(e,r(0))},function(t,e,r){"use strict";function n(t){return null==t?void 0===t?a:c:f&&f in Object(t)?Object(i.a)(t):Object(u.a)(t)}var o=r(3),i=r(16),u=r(17),c="[object Null]",a="[object Undefined]",f=o.a?o.a.toStringTag:void 0;e.a=n},function(t,e,r){"use strict";var n=r(15),o="object"==typeof self&&self&&self.Object===Object&&self,i=n.a||o||Function("return this")();e.a=i},function(t,e,r){"use strict";(function(t){var r="object"==typeof t&&t&&t.Object===Object&&t;e.a=r}).call(e,r(4))},function(t,e,r){"use strict";function n(t){var e=u.call(t,a),r=t[a];try{t[a]=void 0;var n=!0}catch(t){}var o=c.call(t);return n&&(e?t[a]=r:delete t[a]),o}var o=r(3),i=Object.prototype,u=i.hasOwnProperty,c=i.toString,a=o.a?o.a.toStringTag:void 0;e.a=n},function(t,e,r){"use strict";function n(t){return i.call(t)}var o=Object.prototype,i=o.toString;e.a=n},function(t,e,r){"use strict";var n=r(19),o=Object(n.a)(Object.getPrototypeOf,Object);e.a=o},function(t,e,r){"use strict";function n(t,e){return function(r){return t(e(r))}}e.a=n},function(t,e,r){"use strict";function n(t){return null!=t&&"object"==typeof t}e.a=n},function(t,e,r){"use strict";(function(t,n){var o,i=r(23);o="undefined"!=typeof self?self:"undefined"!=typeof window?window:void 0!==t?t:n;var u=Object(i.a)(o);e.a=u}).call(e,r(4),r(22)(t))},function(t,e){t.exports=function(t){if(!t.webpackPolyfill){var e=Object.create(t);e.children||(e.children=[]),Object.defineProperty(e,"loaded",{enumerable:!0,get:function(){return e.l}}),Object.defineProperty(e,"id",{enumerable:!0,get:function(){return e.i}}),Object.defineProperty(e,"exports",{enumerable:!0}),e.webpackPolyfill=1}return e}},function(t,e,r){"use strict";function n(t){var e,r=t.Symbol;return"function"==typeof r?r.observable?e=r.observable:(e=r("observable"),r.observable=e):e="@@observable",e}e.a=n},function(t,e,r){"use strict";(function(t){function n(t,e){var r=e&&e.type;return"Given action "+(r&&'"'+r.toString()+'"'||"an action")+', reducer "'+t+'" returned undefined. To ignore an action, you must explicitly return the previous state. If you want this reducer to hold no value, you can return null instead of undefined.'}function o(t,e,r,n){var o=Object.keys(e),i=r&&r.type===c.a.INIT?"preloadedState argument passed to createStore":"previous state received by the reducer";if(0===o.length)return"Store does not have a valid reducer. Make sure the argument passed to combineReducers is an object whose values are reducers.";if(!Object(a.a)(t))return"The "+i+' has unexpected type of "'+{}.toString.call(t).match(/\s([a-z|A-Z]+)/)[1]+'". Expected argument to be an object with the following keys: "'+o.join('", "')+'"';var u=Object.keys(t).filter(function(t){return!e.hasOwnProperty(t)&&!n[t]});return u.forEach(function(t){n[t]=!0}),u.length>0?"Unexpected "+(u.length>1?"keys":"key")+' "'+u.join('", "')+'" found in '+i+'. Expected to find one of the known reducer keys instead: "'+o.join('", "')+'". Unexpected keys will be ignored.':void 0}function i(t){Object.keys(t).forEach(function(e){var r=t[e];if(void 0===r(void 0,{type:c.a.INIT}))throw new Error('Reducer "'+e+"\" returned undefined during initialization. If the state passed to the reducer is undefined, you must explicitly return the initial state. The initial state may not be undefined. If you don't want to set a value for this reducer, you can use null instead of undefined.");if(void 0===r(void 0,{type:"@@redux/PROBE_UNKNOWN_ACTION_"+Math.random().toString(36).substring(7).split("").join(".")}))throw new Error('Reducer "'+e+"\" returned undefined when probed with a random type. Don't try to handle "+c.a.INIT+' or other actions in "redux/*" namespace. They are considered private. Instead, you must return the current state for any unknown actions, unless it is undefined, in which case you must return the initial state, regardless of the action type. The initial state may not be undefined, but can be null.')})}function u(e){for(var r=Object.keys(e),u={},c=0;c<r.length;c++){var a=r[c];"production"!==t.env.NODE_ENV&&void 0===e[a]&&Object(f.a)('No reducer provided for key "'+a+'"'),"function"==typeof e[a]&&(u[a]=e[a])}var s=Object.keys(u),l=void 0;"production"!==t.env.NODE_ENV&&(l={});var d=void 0;try{i(u)}catch(t){d=t}return function(){var e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},r=arguments[1];if(d)throw d;if("production"!==t.env.NODE_ENV){var i=o(e,u,r,l);i&&Object(f.a)(i)}for(var c=!1,a={},p=0;p<s.length;p++){var v=s[p],y=u[v],h=e[v],b=y(h,r);if(void 0===b){var O=n(v,r);throw new Error(O)}a[v]=b,c=c||b!==h}return c?a:e}}e.a=u;var c=r(1),a=r(2),f=r(5)}).call(e,r(0))},function(t,e,r){"use strict";function n(t,e){return function(){return e(t.apply(void 0,arguments))}}function o(t,e){if("function"==typeof t)return n(t,e);if("object"!=typeof t||null===t)throw new Error("bindActionCreators expected an object or a function, instead received "+(null===t?"null":typeof t)+'. Did you write "import ActionCreators from" instead of "import * as ActionCreators from"?');for(var r=Object.keys(t),o={},i=0;i<r.length;i++){var u=r[i],c=t[u];"function"==typeof c&&(o[u]=n(c,e))}return o}e.a=o},function(t,e,r){"use strict";function n(){for(var t=arguments.length,e=Array(t),r=0;r<t;r++)e[r]=arguments[r];return function(t){return function(r,n,u){var c=t(r,n,u),a=c.dispatch,f=[],s={getState:c.getState,dispatch:function(t){return a(t)}};return f=e.map(function(t){return t(s)}),a=o.a.apply(void 0,f)(c.dispatch),i({},c,{dispatch:a})}}}e.a=n;var o=r(6),i=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var r=arguments[e];for(var n in r)Object.prototype.hasOwnProperty.call(r,n)&&(t[n]=r[n])}return t}},function(t,e,r){"use strict";function n(t){if(Array.isArray(t)){for(var e=0,r=Array(t.length);e<t.length;e++)r[e]=t[e];return r}return Array.from(t)}Object.defineProperty(e,"__esModule",{value:!0}),e.sort=e.colors=e.color=void 0;var o=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var r=arguments[e];for(var n in r)Object.prototype.hasOwnProperty.call(r,n)&&(t[n]=r[n])}return t},i=r(7),u=function(t){return t&&t.__esModule?t:{default:t}}(i),c=e.color=function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},e=arguments[1];switch(e.type){case u.default.ADD_COLOR:return{id:e.id,title:e.title,color:e.color,timestamp:e.timestamp,rating:0};case u.default.RATE_COLOR:return t.id!=e.id?t:o({},t,{rating:e.rating});default:return t}};e.colors=function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:[],e=arguments[1];switch(e.type){case u.default.ADD_COLOR:return[].concat(n(t),[c({},e)]);case u.default.RATE_COLOR:return t.map(function(t){return c(t,e)});case u.default.REMOVE_COLOR:return t.filter(function(t){return t.id!==e.id});default:return t}},e.sort=function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"SORTED_BY_DATE",e=arguments[1];switch(e.type){case u.default.SORT_COLORS:return e.sortBy;default:return t}}},function(t,e,r){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.addColor=e.sortColors=e.rateColor=e.removeColor=void 0;var n=r(7),o=function(t){return t&&t.__esModule?t:{default:t}}(n),i=r(29);e.removeColor=function(t){return{type:o.default.REMOVE_COLOR,id:t}},e.rateColor=function(t,e){return{type:o.default.RATE_COLOR,id:t,rating:e}},e.sortColors=function(t){return"rating"===t?{type:o.default.SORT_COLORS,sortBy:"SORTED_BY_RATING"}:"title"===t?{type:o.default.SORT_COLORS,sortBy:"SORTED_BY_TITLE"}:{type:o.default.SORT_COLORS,sortBy:"SORTED_BY_DATE"}},e.addColor=function(t,e){return{type:o.default.ADD_COLOR,id:(0,i.v4)(),title:t,color:e,timestamp:(new Date).toString()}}},function(t,e,r){var n=r(30),o=r(31),i=o;i.v1=n,i.v4=o,t.exports=i},function(t,e,r){function n(t,e,r){var n=e&&r||0,s=e||[];t=t||{};var l=t.node||o,d=void 0!==t.clockseq?t.clockseq:i;if(null==l||null==d){var p=u();null==l&&(l=o=[1|p[0],p[1],p[2],p[3],p[4],p[5]]),null==d&&(d=i=16383&(p[6]<<8|p[7]))}var v=void 0!==t.msecs?t.msecs:(new Date).getTime(),y=void 0!==t.nsecs?t.nsecs:f+1,h=v-a+(y-f)/1e4;if(h<0&&void 0===t.clockseq&&(d=d+1&16383),(h<0||v>a)&&void 0===t.nsecs&&(y=0),y>=1e4)throw new Error("uuid.v1(): Can't create more than 10M uuids/sec");a=v,f=y,i=d,v+=122192928e5;var b=(1e4*(268435455&v)+y)%4294967296;s[n++]=b>>>24&255,s[n++]=b>>>16&255,s[n++]=b>>>8&255,s[n++]=255&b;var O=v/4294967296*1e4&268435455;s[n++]=O>>>8&255,s[n++]=255&O,s[n++]=O>>>24&15|16,s[n++]=O>>>16&255,s[n++]=d>>>8|128,s[n++]=255&d;for(var g=0;g<6;++g)s[n+g]=l[g];return e||c(s)}var o,i,u=r(8),c=r(9),a=0,f=0;t.exports=n},function(t,e,r){function n(t,e,r){var n=e&&r||0;"string"==typeof t&&(e="binary"===t?new Array(16):null,t=null),t=t||{};var u=t.random||(t.rng||o)();if(u[6]=15&u[6]|64,u[8]=63&u[8]|128,e)for(var c=0;c<16;++c)e[n+c]=u[c];return e||i(u)}var o=r(8),i=r(9);t.exports=n}]);
//# sourceMappingURL=bundle.map