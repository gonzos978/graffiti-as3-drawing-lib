﻿/**  	Graffiti 3.0*  	______________________________________________________________________*  	www.nocircleno.com/graffiti/*//** 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,* 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES* 	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND* 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT* 	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,* 	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING* 	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR* 	OTHER DEALINGS IN THE SOFTWARE.*/package com.nocircleno.graffiti.display {		import flash.display.Sprite;	import flash.display.GraphicsPathWinding;	import flash.display.LineScaleMode;	import flash.display.CapsStyle;	import flash.display.JointStyle;	import flash.events.Event;	import flash.events.FocusEvent;	import flash.events.MouseEvent;	import flash.events.TextEvent;	import flash.geom.Point;	import flash.filters.GlowFilter;	import flash.filters.BlurFilter;	import flash.filters.BitmapFilterQuality;	import flash.geom.Rectangle;	import com.nocircleno.graffiti.events.GraffitiObjectEvent;	import com.nocircleno.graffiti.tools.BrushDefinition;	import com.nocircleno.graffiti.tools.BrushType;		/**	* BrushObject Class displays single brush mark as a GraffitiObject on the GraffitiCanvas.	*	* @langversion 3.0    * @playerversion Flash 10 AIR 1.5 	*/	public class BrushObject extends GraffitiObject	{				private var _container:Sprite;		private var _selectionRect:Sprite;		private var _brushDefinition:BrushDefinition;				/**		* The <code>BrushObject</code> constructor. 		* 		* @param brushDefinition BrushDefinition instance.		*/		public function BrushObject(brushDefinition:BrushDefinition) 		{						// store settings			_brushDefinition = brushDefinition;						// create background			_container = new Sprite();			_container.name = "brush_mark_container";			addChild(_container);						_selectionRect = new Sprite();			_selectionRect.name = "selection_rectangle";			_selectionRect.mouseChildren = false;			_selectionRect.mouseEnabled = false;			addChild(_selectionRect);						// enable double click to edit			this.addEventListener(Event.REMOVED_FROM_STAGE, removeEventHandler);			// draw it			render();					}				/**		* Set the Brush Definition for the Brush Object.		*/		public function set brushDefinition(definition:BrushDefinition):void {						_brushDefinition = definition;						render();					}				public function get brushDefinition():BrushDefinition {			return _brushDefinition;		}				/**		* Set Text selected state.		*/		public override function set selected(select:Boolean):void {						_selected = select;						if (_selected) {								_selectionRect.graphics.clear();								var bounds:Rectangle = _container.getBounds(this);				_selectionRect.graphics.lineStyle(1, GraffitiObject.SELECTED_COLOR, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);				_selectionRect.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);								_selectionRect.filters = [new GlowFilter(GraffitiObject.SELECTED_COLOR, 1, 4, 4, 2, BitmapFilterQuality.HIGH, false, false)];							} else {								_selectionRect.graphics.clear();				_selectionRect.filters = [];							}					}				/**		* Set Brush Edit State. Can not edit brush shapes now.		*/		public override function set editing(edit:Boolean):void {}				/**************************************************************************			Method	: updateSelectionRectangle()						Purpose	: This method will update the display of the selection rect.		***************************************************************************/		protected override function updateSelectionRectangle():void {			_selectionRect.visible = _showSelectionRectangle;		}				/**************************************************************************			Method	: render()						Purpose	: This method will render the brush mark.		***************************************************************************/		private function render():void {						// draw brush mark			_container.graphics.clear();						if(_brushDefinition.type == BrushType.ROUND) {				_container.graphics.lineStyle(_brushDefinition.size, _brushDefinition.color, _brushDefinition.alpha, false, LineScaleMode.NORMAL, CapsStyle.ROUND);			} else {				_container.graphics.beginFill(_brushDefinition.color, _brushDefinition.alpha);			}						_container.graphics.drawPath(_brushDefinition.commands, _brushDefinition.drawingData, GraphicsPathWinding.NON_ZERO); 						// set blur on item			if (_brushDefinition.blur > 0) {				_container.filters = [new BlurFilter(_brushDefinition.blur, _brushDefinition.blur, BitmapFilterQuality.MEDIUM)]			} else {				_container.filters = [];			}					}				/**************************************************************************			Method	: removeEventHandler()						Purpose	: This method will remove the event listeners for this object.					  			Params	: e - Event Object		***************************************************************************/		private function removeEventHandler(e:Event):void {			this.removeEventListener(Event.REMOVED_FROM_STAGE, removeEventHandler);		}			}	}