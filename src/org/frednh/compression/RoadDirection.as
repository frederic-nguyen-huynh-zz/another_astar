/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 16:44
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.compression {

    public class RoadDirection {

        public static const _LEFT_DIRECTION : RoadDirection = new RoadDirection("LEFT", -1, 0);
        public static const _RIGHT_DIRECTION : RoadDirection = new RoadDirection("RIGHT", 1, 0);
        public static const _TOP_DIRECTION : RoadDirection = new RoadDirection("TOP", 0, -1);
        public static const _BOTTOM_DIRECTION : RoadDirection = new RoadDirection("BOTTOM", 0, 1);

        public function RoadDirection(label : String, x : int, y : int) {
            _x = x;
            _y = y;
            _label = label;
        }

        public function get x():int {
            return _x;
        }

        public function get y():int {
            return _y;
        }

        public function toString():String {

            if (x == _LEFT_DIRECTION.x && y == _LEFT_DIRECTION.y) {return _LEFT_DIRECTION._label}
            if (x == _RIGHT_DIRECTION.x && y == _RIGHT_DIRECTION.y) {return _RIGHT_DIRECTION._label}
            if (x == _TOP_DIRECTION.x && y == _TOP_DIRECTION.y) {return _TOP_DIRECTION._label}
            if (x == _BOTTOM_DIRECTION.x && y == _BOTTOM_DIRECTION.y) {return _BOTTOM_DIRECTION._label}

            return "UNKNOWN";
        }

        internal var _label : String;
        private var _x : int;
        private var _y : int;
    }
}
