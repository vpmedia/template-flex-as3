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

package vpmedia.controller {
import flash.events.Event;

import mx.core.FlexGlobals;
import mx.core.UIComponent;
import mx.events.FlexEvent;
import mx.resources.ResourceManager;

import vpmedia.event.ApplicationEvent;
import vpmedia.model.ApplicationModel;

public class ApplicationController extends UIComponent {
    public function ApplicationController() {
        trace(this, "created");

        addEventListener(FlexEvent.CREATION_COMPLETE, onCreationCompleteEvent, false, 0, true);
    }

    /**
     * @private
     * <p>Description: -</p>
     */
    private function onCreationCompleteEvent(event:Event):void {
        trace(this, "onCreationCompleteEvent");

        FlexGlobals.topLevelApplication.systemManager.addEventListener(ApplicationEvent.INIT, onApplicationEvent, false, 0, true);
        FlexGlobals.topLevelApplication.systemManager.addEventListener(ApplicationEvent.COMPLETE, onApplicationEvent, false, 0, true);
        FlexGlobals.topLevelApplication.systemManager.addEventListener(ApplicationEvent.STATE_CHANGE, onApplicationEvent, false, 0, true);
        FlexGlobals.topLevelApplication.systemManager.addEventListener(ApplicationEvent.ERROR, onApplicationEvent, false, 0, true);
        FlexGlobals.topLevelApplication.systemManager.addEventListener(ApplicationEvent.SECURITY_ERROR, onApplicationEvent, false, 0, true);

        // custom event
        //systemManager.addEventListener(RegistrationEvent.REGISTRATION, onRegisterEvent, false, 0, true);
    }

    /**
     * <p>Description: -</p>
     */
    private function onApplicationEvent(event:ApplicationEvent):void {
        trace(this, "onApplicationEvent", event.type);

        var app:Object = FlexGlobals.topLevelApplication;
        var _model:ApplicationModel = app._model;

        // save current state
        _model.app_state = event.type;

        var currentState:String = FlexGlobals.topLevelApplication.currentState;
        //trace(currentState);

        // handle current state
        switch (event.type) {
            case ApplicationEvent.INIT:
                initApp();
                break;
            case ApplicationEvent.COMPLETE:
                _model.view_state = "main";
                break;
            case ApplicationEvent.STATE_CHANGE:
                _model.view_state = currentState;
                break;
            case ApplicationEvent.ERROR:
            case ApplicationEvent.SECURITY_ERROR:
                _model.view_state = "error";
                break;
        }
    }

    /**
     * <p>Description: Init app</p>
     */
    private function initApp():void {
        trace(this, "initApp");

        var app:Object = FlexGlobals.topLevelApplication;
        var _model:ApplicationModel = app._model;

        // load locale language
        if (app.loaderInfo.parameters.hasOwnProperty("language_id")) {
            _model.language_id = app.loaderInfo.parameters.language_id;
        }
        ResourceManager.getInstance().localeChain = [_model.language_id];
        ResourceManager.getInstance().addEventListener("change", onLocaleChange, false, 0, true);

        //app.contextMenu=appContextMenu;

        app.dispatchEvent(new ApplicationEvent(ApplicationEvent.COMPLETE, true, false));
    }

    /**
     * @private (static)
     * <p>Description: Locale change event listener</p>
     */
    private function onLocaleChange(e:Event):void {
        trace(this, "onLocaleChange", e.target);
    }


}

}
