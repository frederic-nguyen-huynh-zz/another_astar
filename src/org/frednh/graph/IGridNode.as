/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 26/10/12
 * Time: 22:09
 * To change this template use File | Settings | File Templates.
 */
package org.frednh.graph {

    /**
     * Interface for a grid node (containing (x,y,z) coordinates
     */
    public interface IGridNode extends INode {
        function get x () : int;
        function get y () : int;
        function get z () : int;
    }
}
