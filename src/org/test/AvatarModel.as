/**
 * Created with IntelliJ IDEA.
 * User: fred
 * Date: 27/10/12
 * Time: 17:23
 * To change this template use File | Settings | File Templates.
 */
package org.test {
    import org.frednh.graph.INode;

    public class AvatarModel {

        public function AvatarModel() {
        }

        public function get position():INode {
            return _position;
        }

        public function set position(value:INode):void {
            _position = value;
        }

        private var _position : INode;
    }
}
