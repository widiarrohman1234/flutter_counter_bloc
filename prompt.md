
1. findAll
curl --request GET \
  --url https://api.ppb.widiarrohman.my.id/api/products \
  --header 'Authorization: Bearer xxx'
- response success
```
{
  "data": [
    {
      "id": 4,
      "documentId": "iys8jrpllg0twad15l65d8s9",
      "nama": "Sepatu Wanita Kulit Asli Premium | BUCINI GV 104 H Leather Shoes - COGNAC, 36",
      "available": true,
      "stock": 10,
      "expired": null,
      "createdAt": "2025-10-28T12:20:37.439Z",
      "updatedAt": "2025-10-28T12:38:01.939Z",
      "publishedAt": "2025-10-28T12:38:01.960Z",
      "description": "Flatshoes Wanita Kulit Asli Premium\nFull Grain Leather Genuie Finish\n\nKode : GV 104 H\nDetail :\n- Material 100% kulit sapi asli\n- Hak flat anti slip",
      "uuid": "zKQKh"
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "pageSize": 25,
      "pageCount": 1,
      "total": 1
    }
  }
}
```
- response error
```
{
  "data": null,
  "error": {
    "status": 404,
    "name": "NotFoundError",
    "message": "Not Found",
    "details": {}
  }
}
```

2. create product
curl --request POST \
  --url https://api.ppb.widiarrohman.my.id/api/products \
  --header 'Authorization: Bearer xxx' \
  --header 'content-type: application/json' \
  --data '{"data":{"name":"test1name","available":"TRUE","stock":20,"image_url":null,"expired":null,"id_category":"6e1355bfb2f942739e8d052e2e5c452d","description":"test1desc"}}' 
- success
```
{
  "data": {
    "id": 6,
    "documentId": "znug39ux9abc5wngk06cm9wh",
    "available": true,
    "stock": 20,
    "expired": null,
    "createdAt": "2025-11-03T02:06:40.223Z",
    "updatedAt": "2025-11-03T02:06:40.223Z",
    "publishedAt": "2025-11-03T02:06:40.233Z",
    "description": "test1desc",
    "name": "test1name"
  },
  "meta": {}
}
```
3. findOne Product
curl --request GET \
  --url https://api.ppb.widiarrohman.my.id/api/products/49d57ca7ce2149ed93f4b90fd2e9bac8 \
  --header 'Authorization: Bearer xxx'
- success
```
{
  "data": {
    "id": 23,
    "documentId": "vheqlefaz3o54spnfwellvcw",
    "available": true,
    "stock": 11,
    "expired": null,
    "createdAt": "2025-11-04T02:55:34.166Z",
    "updatedAt": "2025-11-04T03:20:08.829Z",
    "publishedAt": "2025-11-04T03:20:08.836Z",
    "description": "xgx",
    "name": "gxxgx"
  },
  "meta": {}
}
```

4. update product
curl --request PUT \
  --url https://api.ppb.widiarrohman.my.id/api/products/ccd18754904b4ba9a6db947b05b6ccd8 \
  --header 'Authorization: Bearer xxx' \
  --header 'content-type: application/json' \
  --data '{"data":{"available":true,"stock":21,"expired":"2025-11-02T17:15:00.000Z","description":"test1desc","name":"test1name","id_category":"6e1355bfb2f942739e8d052e2e5c452d"}}'

- success
```
{
  "data": {
    "id": 2,
    "id_category": 4,
    "category_name": "test1name",
    "documentId": "ccd18754904b4ba9a6db947b05b6ccd8",
    "nama": "test1name",
    "description": "test1desc",
    "available": true,
    "stock": 21,
    "expired": "2025-11-02T17:15:00.000Z",
    "createdAt": "2025-11-05 04:42:46",
    "updatedAt": "2025-11-05 04:44:21",
    "publishedAt": "2025-11-05T11:42:46.217914"
  },
  "meta": {}
}
```

5. delete product
curl --request DELETE \
  --url https://api.ppb.widiarrohman.my.id/api/products/26705576ebaa46d389da43912e3800ae \
  --header 'Authorization: Bearer xxx'
- success
```
{
  "message": "Product dengan documentId 26705576ebaa46d389da43912e3800ae berhasil dihapus."
}
```

