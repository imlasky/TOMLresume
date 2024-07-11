// @ts-nocheck

import { parse, stringify } from 'smol-toml'


/** */
export const actions = {
	default:/** @param {import('./$types').RequestEvent} event */  async ({request}) => {
        const formData = await request.formData()

        const res = parse(formData.get('content'));
        console.log(res)
        return {ok:true, textContent: formData.get('content')}
	}
};