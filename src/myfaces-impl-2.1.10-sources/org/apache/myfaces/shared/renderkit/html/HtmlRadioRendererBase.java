/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.myfaces.shared.renderkit.html;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.faces.component.UIComponent;
import javax.faces.component.UIInput;
import javax.faces.component.UINamingContainer;
import javax.faces.component.UISelectOne;
import javax.faces.component.behavior.ClientBehavior;
import javax.faces.component.behavior.ClientBehaviorHolder;
import javax.faces.component.html.HtmlSelectOneRadio;
import javax.faces.context.FacesContext;
import javax.faces.context.ResponseWriter;
import javax.faces.convert.Converter;
import javax.faces.convert.ConverterException;
import javax.faces.model.SelectItem;
import javax.faces.model.SelectItemGroup;

import org.apache.myfaces.shared.renderkit.JSFAttr;
import org.apache.myfaces.shared.renderkit.RendererUtils;
import org.apache.myfaces.shared.renderkit.html.util.JavascriptUtils;
import org.apache.myfaces.shared.renderkit.html.util.ResourceUtils;

/**
 * @author Manfred Geiler (latest modification by $Author: lu4242 $)
 * @author Thomas Spiegl
 * @version $Revision: 1393891 $ $Date: 2012-10-03 21:55:02 -0500 (Wed, 03 Oct 2012) $
 */
public class HtmlRadioRendererBase
        extends HtmlRenderer
{
    //private static final Log log = LogFactory.getLog(HtmlRadioRendererBase.class);
    private static final Logger log = Logger.getLogger(HtmlRadioRendererBase.class.getName());

    private static final String PAGE_DIRECTION = "pageDirection";
    private static final String LINE_DIRECTION = "lineDirection";

    public void encodeEnd(FacesContext facesContext, UIComponent uiComponent) throws IOException
    {
        org.apache.myfaces.shared.renderkit.RendererUtils.checkParamValidity(
                facesContext, uiComponent, UISelectOne.class);

        UISelectOne selectOne = (UISelectOne)uiComponent;

        String layout = getLayout(selectOne);

        boolean pageDirectionLayout = false; // Defaults to LINE_DIRECTION
        if (layout != null)
        {
            if (layout.equals(PAGE_DIRECTION))
            {
                pageDirectionLayout = true;
            }
            else if (layout.equals(LINE_DIRECTION))
            {
                pageDirectionLayout = false;
            }
            else
            {
                log.severe("Wrong layout attribute for component " + 
                        selectOne.getClientId(facesContext) + ": " + layout);
            }
        }

        ResponseWriter writer = facesContext.getResponseWriter();

        Map<String, List<ClientBehavior>> behaviors = null;

        if (uiComponent instanceof ClientBehaviorHolder)
        {
            behaviors = ((ClientBehaviorHolder) uiComponent).getClientBehaviors();
            if (!behaviors.isEmpty())
            {
                ResourceUtils.renderDefaultJsfJsInlineIfNecessary(facesContext, writer);
            }
        }
        
        writer.startElement(HTML.TABLE_ELEM, selectOne);
        HtmlRendererUtils.renderHTMLAttributes(writer, selectOne,
                                               HTML.SELECT_TABLE_PASSTHROUGH_ATTRIBUTES);
        
        if (behaviors != null && !behaviors.isEmpty())
        {
            writer.writeAttribute(HTML.ID_ATTR, selectOne.getClientId(facesContext), null);
        }
        else
        {
            HtmlRendererUtils.writeIdIfNecessary(writer, selectOne, facesContext); 
        }        

        if (!pageDirectionLayout)
        {
            writer.startElement(HTML.TR_ELEM, selectOne);
        }

        Converter converter;
        List selectItemList = org.apache.myfaces.shared.renderkit.RendererUtils.getSelectItemList(
                selectOne, facesContext);
        converter = HtmlRendererUtils.findUIOutputConverterFailSafe(facesContext, selectOne);
        
        Object currentValue = 
            org.apache.myfaces.shared.renderkit.RendererUtils.getStringFromSubmittedValueOrLocalValueReturnNull(
                    facesContext, selectOne);

        int itemNum = 0;

        for (Iterator it = selectItemList.iterator(); it.hasNext(); )
        {
            SelectItem selectItem = (SelectItem)it.next();

            itemNum = renderGroupOrItemRadio(facesContext, selectOne,
                                             selectItem, currentValue,
                                             converter, pageDirectionLayout, itemNum);
        }

        if (!pageDirectionLayout)
        {
            writer.endElement(HTML.TR_ELEM);
        }
        writer.endElement(HTML.TABLE_ELEM);
    }


    protected String getLayout(UIComponent selectOne)
    {
        if (selectOne instanceof HtmlSelectOneRadio)
        {
            return ((HtmlSelectOneRadio)selectOne).getLayout();
        }

        return (String)selectOne.getAttributes().get(JSFAttr.LAYOUT_ATTR);
    }


    protected String getStyleClass(UISelectOne selectOne)
     {
         if (selectOne instanceof HtmlSelectOneRadio)
         {
             return ((HtmlSelectOneRadio)selectOne).getStyleClass();
         }

         return (String)selectOne.getAttributes().get(JSFAttr.STYLE_CLASS_ATTR);
     }


    /**
     * Renders the given SelectItem(Group)
     * @return the itemNum for the next item
     */
    protected int renderGroupOrItemRadio(FacesContext facesContext,
                                         UIComponent uiComponent, SelectItem selectItem,
                                         Object currentValue,
                                         Converter converter, boolean pageDirectionLayout,
                                         Integer itemNum) throws IOException
    {

        ResponseWriter writer = facesContext.getResponseWriter();

        boolean isSelectItemGroup = (selectItem instanceof SelectItemGroup);

        // TODO : Check here for getSubmittedValue. Look at RendererUtils.getValue
        // this is useless object creation
//        Object itemValue = selectItem.getValue();

        UISelectOne selectOne = (UISelectOne)uiComponent;

        if (isSelectItemGroup) 
        {
            if (pageDirectionLayout)
            {
                writer.startElement(HTML.TR_ELEM, selectOne);
            }

            writer.startElement(HTML.TD_ELEM, selectOne);
            if (selectItem.isEscape())
            {
                writer.writeText(selectItem.getLabel(),HTML.LABEL_ATTR);
            }
            else
            {
                writer.write(selectItem.getLabel());
            }
            writer.endElement(HTML.TD_ELEM);

            if (pageDirectionLayout)
            {
                writer.endElement(HTML.TR_ELEM);
                writer.startElement(HTML.TR_ELEM, selectOne);
            }
            writer.startElement(HTML.TD_ELEM, selectOne);

            writer.startElement(HTML.TABLE_ELEM, selectOne);
            writer.writeAttribute(HTML.BORDER_ATTR, "0", null);
            
            if(!pageDirectionLayout)
            {
                writer.startElement(HTML.TR_ELEM, selectOne);
            }

            SelectItemGroup group = (SelectItemGroup) selectItem;
            SelectItem[] selectItems = group.getSelectItems();

            for (SelectItem groupSelectItem : selectItems)
            { 
                itemNum = renderGroupOrItemRadio(facesContext, selectOne, groupSelectItem, currentValue, 
                                                 converter, pageDirectionLayout, itemNum);
            }

            if(!pageDirectionLayout)
            {
                writer.endElement(HTML.TR_ELEM);
            }
            writer.endElement(HTML.TABLE_ELEM);
            writer.endElement(HTML.TD_ELEM);

            if (pageDirectionLayout)
            {
                writer.endElement(HTML.TR_ELEM);
            }

        } 
        else 
        {
            String itemStrValue = org.apache.myfaces.shared.renderkit.RendererUtils.getConvertedStringValue(
                    facesContext, selectOne, converter, selectItem.getValue());
            boolean itemChecked = (itemStrValue == null) ? 
                    itemStrValue == currentValue : 
                    "".equals(itemStrValue) ? 
                            (currentValue == null || itemStrValue.equals(currentValue)) : 
                            itemStrValue.equals(currentValue);
            
            // IF the hideNoSelectionOption attribute of the component is true
            // AND this selectItem is the "no selection option"
            // AND there are currently selected items
            // AND this item (the "no selection option") is not selected
            if (HtmlRendererUtils.isHideNoSelectionOption(uiComponent) && selectItem.isNoSelectionOption() 
                    && currentValue != null && !"".equals(currentValue) && !itemChecked)
            {
                // do not render this selectItem
                return itemNum;
            }
            
            writer.write("\t\t");
            if (pageDirectionLayout)
            {
                writer.startElement(HTML.TR_ELEM, selectOne);
            }
            writer.startElement(HTML.TD_ELEM, selectOne);
    
            boolean itemDisabled = selectItem.isDisabled();
    
            String itemId = renderRadio(facesContext, selectOne, itemStrValue, itemDisabled, 
                    itemChecked, false, itemNum);
    
            // label element after the input
            boolean componentDisabled = isDisabled(facesContext, selectOne);
            boolean disabled = (componentDisabled || itemDisabled);
    
            HtmlRendererUtils.renderLabel(writer, selectOne, itemId, selectItem, disabled);
    
            writer.endElement(HTML.TD_ELEM);
            if (pageDirectionLayout)
            {
                writer.endElement(HTML.TR_ELEM);
            }
            
            // we rendered one radio --> increment itemNum
            itemNum++;
        }
        return itemNum;
    }

    @Deprecated
    protected void renderRadio(FacesContext facesContext,
                               UIComponent uiComponent,
                               String value,
                               String label,
                               boolean disabled,
                               boolean checked, boolean renderId)
            throws IOException
    {
        renderRadio(facesContext, (UIInput) uiComponent, value, disabled, checked, renderId, 0);
    }

    /**
     * Renders the input item
     * @return the 'id' value of the rendered element
     */
    protected String renderRadio(FacesContext facesContext,
                               UIInput uiComponent,
                               String value,
                               boolean disabled,
                               boolean checked,
                               boolean renderId,
                               Integer itemNum)
            throws IOException
    {
        String clientId = uiComponent.getClientId(facesContext);

        String itemId = (itemNum == null)? null : clientId + 
                UINamingContainer.getSeparatorChar(facesContext) + itemNum;

        ResponseWriter writer = facesContext.getResponseWriter();

        writer.startElement(HTML.INPUT_ELEM, uiComponent);

        if (itemId != null)
        {
            writer.writeAttribute(HTML.ID_ATTR, itemId, null);
        }
        else if (renderId)
        {
            writer.writeAttribute(HTML.ID_ATTR, clientId, null);
        }
        writer.writeAttribute(HTML.TYPE_ATTR, HTML.INPUT_TYPE_RADIO, null);
        writer.writeAttribute(HTML.NAME_ATTR, clientId, null);

        if (disabled)
        {
            writer.writeAttribute(HTML.DISABLED_ATTR, HTML.DISABLED_ATTR, null);
        }

        if (checked)
        {
            writer.writeAttribute(HTML.CHECKED_ATTR, HTML.CHECKED_ATTR, null);
        }

        if (value != null)
        {
            writer.writeAttribute(HTML.VALUE_ATTR, value, null);
        }
        else
        {
            writer.writeAttribute(HTML.VALUE_ATTR, "", null);
        }
        
        Map<String, List<ClientBehavior>> behaviors = null;
        if (uiComponent instanceof ClientBehaviorHolder && JavascriptUtils.isJavascriptAllowed(
                facesContext.getExternalContext()))
        {
            behaviors = ((ClientBehaviorHolder) uiComponent).getClientBehaviors();
            
            long commonPropertiesMarked = 0L;
            if (isCommonPropertiesOptimizationEnabled(facesContext))
            {
                commonPropertiesMarked = CommonPropertyUtils.getCommonPropertiesMarked(uiComponent);
            }
            if (behaviors.isEmpty() && isCommonPropertiesOptimizationEnabled(facesContext))
            {
                CommonPropertyUtils.renderChangeEventProperty(writer, 
                        commonPropertiesMarked, uiComponent);
                CommonPropertyUtils.renderEventProperties(writer, 
                        commonPropertiesMarked, uiComponent);
                CommonPropertyUtils.renderFieldEventPropertiesWithoutOnchange(writer, 
                        commonPropertiesMarked, uiComponent);
            }
            else
            {
                HtmlRendererUtils.renderBehaviorizedOnchangeEventHandler(facesContext, writer, uiComponent, behaviors);
                if (isCommonEventsOptimizationEnabled(facesContext))
                {
                    Long commonEventsMarked = CommonEventUtils.getCommonEventsMarked(uiComponent);
                    CommonEventUtils.renderBehaviorizedEventHandlers(facesContext, writer, 
                            commonPropertiesMarked, commonEventsMarked, uiComponent, behaviors);
                    CommonEventUtils.renderBehaviorizedFieldEventHandlersWithoutOnchange(
                        facesContext, writer, commonPropertiesMarked, commonEventsMarked, uiComponent, behaviors);
                }
                else
                {
                    HtmlRendererUtils.renderBehaviorizedEventHandlers(facesContext, writer, uiComponent, behaviors);
                    HtmlRendererUtils.renderBehaviorizedFieldEventHandlersWithoutOnchange(
                            facesContext, writer, uiComponent, behaviors);
                }
            }
            HtmlRendererUtils.renderHTMLAttributes(writer, uiComponent, 
                    HTML.INPUT_PASSTHROUGH_ATTRIBUTES_WITHOUT_DISABLED_AND_STYLE_AND_EVENTS);
        }
        else
        {
            HtmlRendererUtils.renderHTMLAttributes(writer, uiComponent, 
                    HTML.INPUT_PASSTHROUGH_ATTRIBUTES_WITHOUT_DISABLED_AND_STYLE);
        }

        if (isDisabled(facesContext, uiComponent))
        {
            writer.writeAttribute(org.apache.myfaces.shared.renderkit.html.HTML.DISABLED_ATTR, Boolean.TRUE, null);
        }

        writer.endElement(HTML.INPUT_ELEM);

        return itemId;
    }


    protected boolean isDisabled(FacesContext facesContext, UIComponent uiComponent)
    {
        //TODO: overwrite in extended HtmlRadioRenderer and check for enabledOnUserRole
        if (uiComponent instanceof HtmlSelectOneRadio)
        {
            return ((HtmlSelectOneRadio)uiComponent).isDisabled();
        }

        return org.apache.myfaces.shared.renderkit.RendererUtils.getBooleanAttribute(
                uiComponent, HTML.DISABLED_ATTR, false);
    }


    public void decode(FacesContext facesContext, UIComponent uiComponent)
    {
        org.apache.myfaces.shared.renderkit.RendererUtils.checkParamValidity(facesContext, uiComponent, null);
        if (uiComponent instanceof UIInput)
        {
            HtmlRendererUtils.decodeUISelectOne(facesContext, uiComponent);
        }
        if (uiComponent instanceof ClientBehaviorHolder &&
                !HtmlRendererUtils.isDisabled(uiComponent))
        {
            HtmlRendererUtils.decodeClientBehaviors(facesContext, uiComponent);
        }
    }


    public Object getConvertedValue(FacesContext facesContext, UIComponent uiComponent, Object submittedValue)
        throws ConverterException
    {
        RendererUtils.checkParamValidity(facesContext, uiComponent, UISelectOne.class);
        return org.apache.myfaces.shared.renderkit.RendererUtils.getConvertedUISelectOneValue(facesContext,
                                                                                               (UISelectOne)uiComponent,
                                                                                               submittedValue);
    }

}
