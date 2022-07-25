/* tslint:disable */
/* eslint-disable */
/**
 * test-open-api
 * ほげほげ説明
 *
 * The version of the OpenAPI document: 1.0
 * Contact: test@example.com
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

import { exists, mapValues } from '../runtime';
/**
 * 
 * @export
 * @interface CreateBlogRequest
 */
export interface CreateBlogRequest {
    /**
     * 
     * @type {string}
     * @memberof CreateBlogRequest
     */
    title: string;
    /**
     * 
     * @type {string}
     * @memberof CreateBlogRequest
     */
    contents?: string;
}

/**
 * Check if a given object implements the CreateBlogRequest interface.
 */
export function instanceOfCreateBlogRequest(value: object): boolean {
    let isInstance = true;
    isInstance = isInstance && "title" in value;

    return isInstance;
}

export function CreateBlogRequestFromJSON(json: any): CreateBlogRequest {
    return CreateBlogRequestFromJSONTyped(json, false);
}

export function CreateBlogRequestFromJSONTyped(json: any, ignoreDiscriminator: boolean): CreateBlogRequest {
    if ((json === undefined) || (json === null)) {
        return json;
    }
    return {
        
        'title': json['title'],
        'contents': !exists(json, 'contents') ? undefined : json['contents'],
    };
}

export function CreateBlogRequestToJSON(value?: CreateBlogRequest | null): any {
    if (value === undefined) {
        return undefined;
    }
    if (value === null) {
        return null;
    }
    return {
        
        'title': value.title,
        'contents': value.contents,
    };
}
