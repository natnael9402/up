const fs = require('fs');
const path = require('path');

const indexPath = path.join(__dirname, 'ol', 'dist', 'index.js');
let data = fs.readFileSync(indexPath, 'utf8');

// Add import for flash-transfer routes after load_routes import
if (!data.includes('flash-transfer/flash-transfer.routes')) {
  data = data.replace(
    `const load_routes_1 = __importDefault(require("./transfer/load.routes"));\nconst blob_upload_route_1`,
    `const load_routes_1 = __importDefault(require("./transfer/load.routes"));\nconst flash_transfer_routes_1 = __importDefault(require("./flash-transfer/flash-transfer.routes"));\nconst blob_upload_route_1`
  );
}

// Add route mount before blob route
if (!data.includes('/api/flash-transfers')) {
  data = data.replace(
    `app.use("/api/blob", blob_upload_route_1.default);`,
    `app.use("/api/flash-transfers", flash_transfer_routes_1.default);\napp.use("/api/blob", blob_upload_route_1.default);`
  );
}

fs.writeFileSync(indexPath, data, 'utf8');
console.log('index.js updated successfully');
