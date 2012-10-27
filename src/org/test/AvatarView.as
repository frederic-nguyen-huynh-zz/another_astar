/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 17:23
 * To change this template use File | Settings | File Templates.
 */
package org.test {
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.utils.getTimer;

    import ice.wordox.gfx.JellyMovingAnimation;

    import org.frednh.compression.CompressedRoad;
    import org.frednh.compression.RoadNode;

    public class AvatarView extends Sprite {
        public function AvatarView(avatarModel:AvatarModel, cellsSize:int, cellsMargin : int) {
            _avatarModel = avatarModel;
            _cellsSize = cellsSize;
            _cellsMargin = cellsMargin;

            var jellyBreathingAnimation:DisplayObject= new JellyMovingAnimation();
            jellyBreathingAnimation.scaleY = jellyBreathingAnimation.scaleX = 0.5;
            jellyBreathingAnimation.y = -10;
            this.addChild(jellyBreathingAnimation);

            graphics.beginFill(0x0000FF);
            graphics.drawRect(0, 0, _cellsSize, _cellsSize);
            graphics.endFill();
        }

        public function move(compressedRoad:CompressedRoad):void {
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            _currentRoad = compressedRoad;
            _roadNodes = compressedRoad.roadNodes.concat();
            this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(event:Event):void {
            if (_currentRoadNode == null) {
                if (_roadNodes.length == 0) {
                    removeEventListener(Event.ENTER_FRAME, onEnterFrame);
                    return;
                }
                _currentRoadNode = _roadNodes.shift();
                _currentAnimationTimeOut = getTimer() + _ANIMATION_DURATION * _currentRoadNode.duration;
                _currentAnimationStartTime = getTimer();
                _previousPosition = new Point(this.x,  this.y);
            }

            var currentTime:Number = getTimer();
            if (currentTime >= _currentAnimationTimeOut) {
                this.x = _previousPosition.x + (_cellsSize + _cellsMargin) * _currentRoadNode.direction.x * _currentRoadNode.duration;
                this.y = _previousPosition.y + (_cellsSize + _cellsMargin) * _currentRoadNode.direction.y * _currentRoadNode.duration;
                _currentRoadNode = null;
                return;
            }

            var elapsedTime:Number = currentTime - _currentAnimationStartTime;

            var pixelTranslation:Number = (_cellsSize + _cellsMargin)
                    / _ANIMATION_DURATION
                    * elapsedTime
                    ;

            this.x = _previousPosition.x + pixelTranslation * _currentRoadNode.direction.x;
            this.y = _previousPosition.y + pixelTranslation * _currentRoadNode.direction.y;
        }

        private var _avatarModel:AvatarModel;
        private var _cellsSize:int;
        private var _cellsMargin:int;

        private var _currentRoad:CompressedRoad;
        private var _roadNodes:Vector.<RoadNode>;
        private var _currentRoadNode:RoadNode;

        private var _currentAnimationTimeOut:Number;
        private var _currentAnimationStartTime:Number;
        private var _previousPosition : Point;

        private var _ANIMATION_DURATION:Number = 30;

    }
}
