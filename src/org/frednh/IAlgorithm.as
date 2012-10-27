/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 26/10/12
 * Time: 22:19
 * To change this template use File | Settings | File Templates.
 */
package org.frednh {
    import org.frednh.graph.INode;

    public interface IAlgorithm {
        function execute (fromNode : INode, toNode : INode, nodesList : Vector.<INode>) : Vector.<INode>;
        function get lastExecutionCost():int;
        function get trackNodesCount():int;
        function get redondance():int;
    }
}
