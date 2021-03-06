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

/**
 * A potential rule for Metadata on the passed MetadataTarget
 * 
 * @see com.sun.facelets.tag.Metadata
 * @see com.sun.facelets.tag.MetadataTarget
 * @author Jacob Hookom
 * @version $Id: MetaRule.java 1187701 2011-10-22 12:21:54Z bommel $
 */
public abstract class MetaRule
{
    /**
     * @param name
     * @param attribute
     * @param meta
     * @return
     */
    public abstract Metadata applyRule(String name, TagAttribute attribute, MetadataTarget meta);
}
