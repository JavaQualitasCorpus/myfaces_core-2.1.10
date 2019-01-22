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
package javax.faces.view.facelets;

import java.io.IOException;

import javax.faces.component.UIComponent;

/**
 * @author Simon Lessard (latest modification by $Author: struberg $)
 * @version $Revision: 1188267 $ $Date: 2011-10-24 13:09:08 -0500 (Mon, 24 Oct 2011) $
 *
 * @since 2.0
 */
public final class CompositeFaceletHandler implements FaceletHandler
{
    private final FaceletHandler[] children;
    private final int len;

    public CompositeFaceletHandler(FaceletHandler[] children)
    {
        this.children = children;
        this.len = children.length;
    }

    /**
     * {@inheritDoc}
     */
    public void apply(FaceletContext ctx, UIComponent parent) throws IOException
    {
        for (int i = 0; i < len; i++)
        {
            this.children[i].apply(ctx, parent);
        }
    }

    public FaceletHandler[] getHandlers()
    {
        return this.children;
    }
}
