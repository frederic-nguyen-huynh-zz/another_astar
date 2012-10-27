/**
 */
package org.frednh.graph {
    /**
	 * Graph node interface
	 */
	public interface INode {

		/**
		 * Neighbour nodes. Available for non oriented graphs.
		 */
		function get neighbours () : Vector.<INode>;

		/**
		 * Predecessors nodes. Available for oriented graphs.
		 */
		function get predecessors () : Vector.<INode>;

		/**
		 * Adds a successor
		 * @param node New successor
		 * @param verticeValue Vertice value
		 */
		function addSuccessor (node : INode, verticeValue : int) : void;

        /**
         * Removes a successor
         * @param node
         */
        function removeSuccessor (node : INode) : void;
		/**
		 * Successor nodes. Available for oriented graphs.
		 */
		function get successors () : Vector.<INode>;

		/**
		 * Heuristic distance from this node to another. Can be everywhere.
		 * @param toNode
		 * @return
		 */
		function heuristicDistance (toNode : INode) : Number;
        function get heuristicDistanceInRoad () : Number;
        function set heuristicDistanceInRoad (value : Number) : void;

        /**
		 * Distance from this node to another.
		 * @param toNode A neighbour, or predecessor, or successor node.
		 * @return
		 */
		function getVerticeValue (toNode : INode) : int;

		/**
		 * Current distance in the road
		 */
		function get distanceInRoad () : int;
		function set distanceInRoad (value : int) : void;

        function get isEnabled () : Boolean;
        function set isEnabled (value : Boolean) : void;

        function get checked () : Boolean;
        function set checked (value : Boolean) : void;
    }
}
