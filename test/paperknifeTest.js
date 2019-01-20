const test = require('ava');
const Paperknife = require('../paperknife.js');

test('Paperknife.parse is available', async (t) => {
    t.true(typeof Paperknife.parse === 'function');
});

test('Paperknife.parse validates correct mail addresses successfully', async (t) => {
    t.deepEqual(Paperknife.parse('"Marius M." <marius@twostairs.co>'), [
	    [
			{
				type: 'displayname',
				value: 'Marius M.',
			},
			{
				type: 'localpart',
				value: 'marius',
			},
			{
				type: 'domain',
				value: 'twostairs.co',
			},
			{}
	    ]
  	]);
});
