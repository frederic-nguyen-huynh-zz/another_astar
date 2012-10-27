/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 00:52
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.graph {
    import flash.events.Event;

    public class NodeEvent extends Event {

        public static const NODE_TOUCH:String = "nodeTouch";
        public static const MOVE_TO_NODE:String = "moveToNode";

        public function NodeEvent(type:String, nodeX:int, nodeY:int) {
            super(type);
            _nodeX = nodeX;
            _nodeY = nodeY;
        }


        public function get nodeX():int {
            return _nodeX;
        }

        public function get nodeY():int {
            return _nodeY;
        }

        override public function clone():Event {
            return new NodeEvent(type, nodeX, nodeY);
        }

        private var _nodeX:int;
        private var _nodeY:int;
    }
}
