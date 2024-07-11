
import { parse, stringify } from 'smol-toml'


/** @type {import('./$types').Actions} */
export const actions = {
	default: async ({request}) => {
        const formData = await request.formData()

        const res = parse(formData.get('content'));
        console.log(res)
        return {ok:true, textContent: formData.get('content')}
	}
};