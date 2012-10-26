/**
 * Created with IntelliJ IDEA.
 * User: fredericn
 * Date: 26/10/12
 * Time: 15:46
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.graph {
	import flash.utils.Dictionary;

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

		public function get successors():Vector.<INode> {
			return _successors;
		}

		public function get distanceInRoad():int {
			return _distanceInRoad;
		}

		public function set distanceInRoad(value:int):void {
			_distanceInRoad = value;
		}

		public function get predecessors():Vector.<INode> {
			return _predecessors;
		}

		public function heuristicDistance(toNode:INode):int {
			return 0;
		}

		public function getVerticeValue(toNode:INode):int {
			return _verticesValues[toNode];
		}

		public function toString():String {
			return "Node{" + String(_name) + ", dist=" + _distanceInRoad + "} ";
		}

		public static function minDistanceSorting(nodeA : INode, nodeB : INode) : int {
			if (nodeA.distanceInRoad < nodeB.distanceInRoad) return -1;
			if (nodeA.distanceInRoad > nodeB.distanceInRoad) return 1;
			return 0;
		}

		private function resetNode () : void {
			_predecessors = new Vector.<INode>();
			_successors = new Vector.<INode>();
			_verticesValues = new Dictionary();
			_distanceInRoad = 0;
		}

		private var _name : String;
		private var _predecessors : Vector.<INode>;
		private var _successors : Vector.<INode>;
		private var _verticesValues : Dictionary;
		private var _distanceInRoad : int;
	}
}
