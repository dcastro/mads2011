/*
 * jQuery Hotkeys Plugin
 * Copyright 2010, John Resig
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * Based upon the plugin by Tzury Bar Yochay:
 * http://github.com/tzuryby/hotkeys
 *
 * Original idea by:
 * Binny V A, http://www.openjs.com/scripts/events/keyboard_shortcuts/
*/
(function(a){function b(b){if(typeof b.data!="string")return;var c=b.handler,d=b.data.toLowerCase().split(" ");b.handler=function(b){var e=b.type!=="keypress"&&a.hotkeys.specialKeys[b.which],f=String.fromCharCode(b.which).toLowerCase(),g,h="",i={};b.altKey&&e!=="alt"&&(h+="alt+"),b.ctrlKey&&e!=="ctrl"&&(h+="ctrl+"),b.metaKey&&!b.ctrlKey&&e!=="meta"&&(h+="meta+"),b.shiftKey&&e!=="shift"&&(h+="shift+"),e?i[h+e]=!0:(i[h+f]=!0,i[h+a.hotkeys.shiftNums[f]]=!0,h==="shift+"&&(i[a.hotkeys.shiftNums[f]]=!0));for(var j=0,k=d.length;j<k;j++)if(i[d[j]])return c.apply(this,arguments)}}a.hotkeys={version:"0.8",specialKeys:{8:"backspace",9:"tab",13:"return",16:"shift",17:"ctrl",18:"alt",19:"pause",20:"capslock",27:"esc",32:"space",33:"pageup",34:"pagedown",35:"end",36:"home",37:"left",38:"up",39:"right",40:"down",45:"insert",46:"del",96:"0",97:"1",98:"2",99:"3",100:"4",101:"5",102:"6",103:"7",104:"8",105:"9",106:"*",107:"+",109:"-",110:".",111:"/",112:"f1",113:"f2",114:"f3",115:"f4",116:"f5",117:"f6",118:"f7",119:"f8",120:"f9",121:"f10",122:"f11",123:"f12",144:"numlock",145:"scroll",191:"/",224:"meta"},shiftNums:{"`":"~",1:"!",2:"@",3:"#",4:"$",5:"%",6:"^",7:"&",8:"*",9:"(",0:")","-":"_","=":"+",";":": ","'":'"',",":"<",".":">","/":"?","\\":"|"}},a.each(["keydown","keyup","keypress"],function(){a.event.special[this]={add:b}})})(jQuery)