-- Input image colors must be white or black, other colors are not permited
ErosionShader = love.graphics.newShader [[
	
	extern float iter;
	extern vec2 Size;
	
	int N(Image texture, vec2 tc) {
		
		float [] P = float[8] (
			Texel(texture, tc + vec2(0, -1) / Size).r,
			Texel(texture, tc + vec2(1, -1) / Size).r,
			Texel(texture, tc + vec2(1, 0) / Size).r,
			Texel(texture, tc + vec2(1, 1) / Size).r,
			Texel(texture, tc + vec2(0, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 0) / Size).r,
			Texel(texture, tc + vec2(-1, -1) / Size).r
		);
		
		int sum = 0;
		
		for ( int i = 0; i < 8; i++) {
			if ( P[i] == 0.0 ) {
				sum++;
			}
		}
		
		return sum;
		
	}
	
	int S(Image texture, vec2 tc) {
		
		int transitions = 0;
		
		float [] P = float[8] (
			Texel(texture, tc + vec2(0, -1) / Size).r,
			Texel(texture, tc + vec2(1, -1) / Size).r,
			Texel(texture, tc + vec2(1, 0) / Size).r,
			Texel(texture, tc + vec2(1, 1) / Size).r,
			Texel(texture, tc + vec2(0, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 0) / Size).r,
			Texel(texture, tc + vec2(-1, -1) / Size).r
		);
		
		for (int i = 0; i < 7; i++) {
			if ( P[i] == 0.0 && P[i + 1] == 1.0 ) {
				transitions++;
			}
		}
		
		if ( P[7] == 0.0 && P[0] == 1.0 ) {
			transitions++;
		}
		
		return transitions;
		
	}
	
	vec4 effect(vec4 color, Image texture, vec2 tc, vec2 pixelCoords) {
		
		if ( Texel(texture, tc).r == 0.0 ) {
			
			float n = N(texture, tc);
			
			float P2 = Texel(texture, tc + vec2(0, -1) / Size).r;
			float P4 = Texel(texture, tc + vec2(1, 0) / Size).r;
			float P6 = Texel(texture, tc + vec2(0, 1) / Size).r;
			float P8 = Texel(texture, tc + vec2(-1, -1) / Size).r;
			
			bool M1 = mod(iter, 2) == 1.0 ? ( P2 == 1.0 || P4 == 1.0 || P6 == 1.0 ) : ( P2 == 1.0 || P4 == 1.0 || P8 == 1.0 );
			bool M2 = mod(iter, 2) == 1.0 ? ( P4 == 1.0 || P6 == 1.0 || P8 == 1.0 ) : ( P2 == 1.0 || P6 == 1.0 || P8 == 1.0 );
			
			if ( S(texture, tc) == 1 && n >= 3 && n <= 6 && M1 && M2 ) {
				
				return vec4(0.0);
				
			}
			
		}
		
		return vec4(1.0);
		
	}
]]

SkeletonShader = love.graphics.newShader [[
	
	extern float iter;
	extern vec2 Size;
	
	int N(Image texture, vec2 tc) {
		
		float [] P = float[8] (
			Texel(texture, tc + vec2(0, -1) / Size).r,
			Texel(texture, tc + vec2(1, -1) / Size).r,
			Texel(texture, tc + vec2(1, 0) / Size).r,
			Texel(texture, tc + vec2(1, 1) / Size).r,
			Texel(texture, tc + vec2(0, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 0) / Size).r,
			Texel(texture, tc + vec2(-1, -1) / Size).r
		);
		
		int sum = 0;
		
		for ( int i = 0; i < 8; i++) {
			if ( P[i] == 0.0 ) {
				sum++;
			}
		}
		
		return sum;
		
	}
	
	int S(Image texture, vec2 tc) {
		
		int transitions = 0;
		
		float [] P = float[8] (
			Texel(texture, tc + vec2(0, -1) / Size).r,
			Texel(texture, tc + vec2(1, -1) / Size).r,
			Texel(texture, tc + vec2(1, 0) / Size).r,
			Texel(texture, tc + vec2(1, 1) / Size).r,
			Texel(texture, tc + vec2(0, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 1) / Size).r,
			Texel(texture, tc + vec2(-1, 0) / Size).r,
			Texel(texture, tc + vec2(-1, -1) / Size).r
		);
		
		for (int i = 0; i < 7; i++) {
			if ( P[i] == 0.0 && P[i + 1] == 1.0 ) {
				transitions++;
			}
		}
		
		if ( P[7] == 0.0 && P[0] == 1.0 ) {
			transitions++;
		}
		
		return transitions;
		
	}
	
	vec4 effect(vec4 color, Image texture, vec2 tc, vec2 pixelCoords) {
		
		if ( Texel(texture, tc).r == 0.0 ) {
			
			float n = N(texture, tc);
			
			float P2 = Texel(texture, tc + vec2(0, -1) / Size).r;
			float P4 = Texel(texture, tc + vec2(1, 0) / Size).r;
			float P6 = Texel(texture, tc + vec2(0, 1) / Size).r;
			float P8 = Texel(texture, tc + vec2(-1, -1) / Size).r;
			
			bool M1 = mod(iter, 2) == 1.0 ? ( P2 == 1.0 || P4 == 1.0 || P6 == 1.0 ) : ( P2 == 1.0 || P4 == 1.0 || P8 == 1.0 );
			bool M2 = mod(iter, 2) == 1.0 ? ( P4 == 1.0 || P6 == 1.0 || P8 == 1.0 ) : ( P2 == 1.0 || P6 == 1.0 || P8 == 1.0 );
			
			if ( S(texture, tc) == 1 && n >= 3 && n <= 6 && M1 && M2 ) {
				
				return vec4(1.0);
				
			}
			
		}
		
		return Texel(texture, tc);
		
	}
]]
