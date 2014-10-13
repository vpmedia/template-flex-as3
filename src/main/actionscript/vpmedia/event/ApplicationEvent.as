/*
 * =BEGIN CLOSED LICENSE
 *
 *  Copyright(c) 2014 Andras Csizmadia.
 *  http://www.vpmedia.eu
 *
 *  For information about the licensing and copyright please
 *  contact Andras Csizmadia at andras@vpmedia.eu.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 * =END CLOSED LICENSE
 */

package vpmedia.event
{
  import flash.events.Event;

  public  class ApplicationEvent extends Event 
  {
    
    public static const INIT:String = "init";
    public static const COMPLETE:String = "complete";
    public static const STATE_CHANGE:String = "state_change";
    public static const ERROR:String = "error";
    public static const SECURITY_ERROR:String = "security_error";
    
    public var data:*;
    
    /**
     * <p>Description: </p>
     */
    public function ApplicationEvent (type:String,bubbles:Boolean=false,cancelable:Boolean=false)
    {
        super (type,bubbles,cancelable);
    }
    
    /**
     * <p>Description: </p>
     */
    override public  function clone ():Event
    {
        return new ApplicationEvent(type,bubbles,cancelable);
    }
    
    // EOC
    
  }
  
  // EOP
  
}
