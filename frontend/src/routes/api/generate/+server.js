import { json } from '@sveltejs/kit';

/** @type {import('./$types').RequestHandler} */
export function POST({request}) {

    return json({ok:true})
}