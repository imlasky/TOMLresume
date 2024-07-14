
import { PRIVATE_SERVER_ADDRESS } from '$env/static/private';
import { json } from '@sveltejs/kit';
import { parse, stringify } from 'smol-toml'


/** @type {import('./$types').Actions} */
export const actions = {
	default: async ({request}) => {
        const formData = await request.formData()

        const res = parse(formData.get('content'));

        const response = await fetch(PRIVATE_SERVER_ADDRESS, {
            method: 'POST', // Specify the request method
            headers: {
                'Content-Type': 'application/json' // Specify the content type as JSON
            },
            body: JSON.stringify(res) 
        })
        .then((response) => {
            const reader = response.body.getReader();
            return new ReadableStream({
              start(controller) {
                return pump();
                function pump() {
                  return reader.read().then(({ done, value }) => {
                    // When no more data needs to be consumed, close the stream
                    if (done) {
                      controller.close();
                      return;
                    }
                    // Enqueue the next data chunk into our target stream
                    controller.enqueue(value);
                    return pump();
                  });
                }
              },
            });
          })
          // Create a new response out of the stream
        .then((stream) => new Response(stream))
            // Create an object URL for the response
        .then((response) => response.blob())
        
        const arrayBuffer = await response.arrayBuffer();
        const pdfBase64 = Buffer.from(arrayBuffer).toString('base64');
    
        console.log(pdfBase64)
        return { pdfBase64,  textContent:formData.get('content') };
        
	}
};