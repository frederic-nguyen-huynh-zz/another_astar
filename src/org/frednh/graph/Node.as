/**
 * Created with IntelliJ IDEA.
 * User: fredericn
 * Date: 26/10/12
 * Time: 15:46
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.graph {
    import flash.utils.Dictionary;

    import org.frednh.dijkstra.DijkstraAlgorithm;

    public class Node implements INode{

		public function Node(name : String) {
			resetNode();
			_name = name;
		}

		// TODO : to implement!
		public function get neighbours () : Vector.<INode> {
			return null;
		}

		public function addSuccessor(node:INode, verticeValue:int):void {
			_successors.push(node);
			_verticesValues[node] = verticeValue;
		}

        public function removeSuccessor(node:INode):void {
            _successors.splice(_successors.indexOf(node), 1);
            _verticesValues[node] = null;
            delete _verticesValues[node];
        }

        public function get successors():Vector.<INode> {
			return _successors;
		}

		public function get distanceInRoad():int {
			return _distanceInRoad;
		}

		public function set distanceInRoad(value:int):void {
			_distanceInRoad = value;
		}

		public function get heuristicDistanceInRoad():Number {
            return _heuristicDistanceInRoad;
        }

        public function set heuristicDistanceInRoad(value:Number):void {
            _heuristicDistanceInRoad = value;
        }

        public function get predecessors():Vector.<INode> {
			return _predecessors;
		}

		public function heuristicDistance(toNode:INode):Number {
			return 0;
		}

		public function getVerticeValue(toNode:INode):int {
			return _verticesValues[toNode];
		}

		public function toString():String {
			return "Node{" + String(_name) + ", dist=" + _distanceInRoad + "} ";
		}

		public static function minDistanceSorting(nodeA : INode, nodeB : INode) : int {
            DijkstraAlgorithm.lastExecutionInc++;
			if (nodeA.heuristicDistanceInRoad < nodeB.heuristicDistanceInRoad) return -1;
			if (nodeA.heuristicDistanceInRoad > nodeB.heuristicDistanceInRoad) return 1;
			return 0;
		}

        public function get isEnabled():Boolean {
            return _isEnabled;
        }

        public function set isEnabled(value:Boolean):void {
            _isEnabled = value;
        }

        public function get checked():Boolean {
            return _checked;
        }

        public function set checked(value:Boolean):void {
            _checked = value;
        }

        private function resetNode () : void {
			_predecessors = new Vector.<INode>();
			_successors = new Vector.<INode>();
			_verticesValues = new Dictionary();
			_distanceInRoad = 0;
		}

        private var _heuristicDistanceInRoad : Number;
		private var _name : String;
		private var _predecessors : Vector.<INode>;
		private var _successors : Vector.<INode>;
		private var _verticesValues : Dictionary;
		private var _distanceInRoad : int;
        private var _isEnabled : Boolean = true;
        private var _checked : Boolean = false;
	}
}
