/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 16:43
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.compression {
    public class RoadNode {

        public function RoadNode(direction : RoadDirection) {
            _direction = direction;
        }

        public function get direction():RoadDirection {
            return _direction;
        }

        public function get duration():int {
            return _duration;
        }

        public function set duration(value:int):void {
            _duration = value;
        }

        public function toString():String {
            return "[" + String(_direction) + " : " + String(_duration) + "]";
        }

        private var _duration : int = 0;
        private var _direction : RoadDirection;

    }
}
