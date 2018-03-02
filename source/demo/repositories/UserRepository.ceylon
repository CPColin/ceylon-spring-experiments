import ceylon.interop.spring {
	CeylonRepository
}

import demo.domain {
	User
}

shared interface UserRepository satisfies CeylonRepository<User, Integer> {}