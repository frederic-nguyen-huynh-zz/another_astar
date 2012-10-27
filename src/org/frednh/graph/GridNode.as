/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 26/10/12
 * Time: 22:08
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.graph {
    public class GridNode implements IGridNode {

        public function GridNode(name : String
                , x : int
                , y : int
                , z : int) {
            _x = x;
            _y = y;
            _z = z;
            _node = new Node(name);
        }

        public function get neighbours():Vector.<INode> {
            return _node.neighbours;
        }

        public function get predecessors():Vector.<INode> {
            return _node.predecessors;
        }

        public function addSuccessor(node:INode, verticeValue:int):void {
            _node.addSuccessor(node, verticeValue);
        }

        public function removeSuccessor(node:INode):void {
            _node.removeSuccessor(node);
        }

        public function get successors():Vector.<INode> {
            return _node.successors;
        }

        public function heuristicDistance(toNode:INode):Number {
            if (toNode is IGridNode) {
                var toGridNode : IGridNode = IGridNode(toNode);
                var number:Number = Math.pow(Math.abs(toGridNode.x - x), 2) + Math.pow(Math.abs(toGridNode.y - y), 2);
                return Math.sqrt(number);
            }
            return _node.heuristicDistance(toNode);
        }

        public function get heuristicDistanceInRoad():Number {
            return _node.heuristicDistanceInRoad;
        }

        public function set heuristicDistanceInRoad(value:Number):void {
            _node.heuristicDistanceInRoad = value;
        }

        public function getVerticeValue(toNode:INode):int {
            // We got altitude, so we use it in the distance:
            var verticeValue:int = _node.getVerticeValue(toNode);
            var altitudeDelta : int = Math.max(0, IGridNode(toNode).z - _z);
            return verticeValue + altitudeDelta * 2;
        }

        public function get distanceInRoad():int {
            return _node.distanceInRoad;
        }

        public function set distanceInRoad(value:int):void {
            _node.distanceInRoad = value;
        }

        public function get isEnabled():Boolean {
            return _node.isEnabled;
        }

        public function set isEnabled(value:Boolean):void {
            _node.isEnabled = value;
        }

        public function get x():int {
            return _x;
        }

        public function get y():int {
            return _y;
        }

        public function get z():int {
            return _z;
        }

        public function get checked():Boolean {
            return _node.checked;
        }

        public function set checked(value:Boolean):void {
            _node.checked = value;
        }

        public function toString():String {
            return String(_node);
        }

        private var _x : int;
        private var _y : int;
        private var _z : int;
        private var _node : INode;
    }
}
